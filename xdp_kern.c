/*
 * Основной код программы для машины eBPF
 */

#include <linux/bpf.h>
#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/in.h>

#include "hash_cookie.h"
#include "common_struct.h"


// Структура для сохранения сетевого пакета
struct NetPacket{
    struct xdp_md* ctx;
    struct iphdr* ipv4;      // структура для хранения IP заголовка пакета
    struct tcphdr* tcp;      // TCP заголовок
    struct ethhdr* eth;      // заголовок Ethernet-кадра
};


// Карта для хэш таблицы
struct bpf_map_def SEC("maps") hash_table_map = {
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(__u32),
    .value_size = sizeof(__u32),
    .max_entries = 10240,
}; 
 

// Карта для белого листа
struct bpf_map_def SEC("maps") white_table_map = {
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(__u32),
    .value_size = sizeof(__s16),
    .max_entries = 2048,
};


// Карта для структуры статистики
struct bpf_map_def SEC("maps") stat_map = {
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(int),
    .value_size = sizeof(struct StatData),
    .max_entries = 1,
};


// Функция записи в хэш таблицу
void write_hash_table(__u32 hash, __u32 key){
    bpf_map_update_elem(&hash_table_map, &key, &hash, BPF_ANY);
    //bpf_printk("HashCookieClient %x     key: %x", hash, key);
}


// Функция записи в белый список
void write_white_table(__s16 reg, __u32 key){
    bpf_map_update_elem(&white_table_map, &key, &reg, BPF_ANY);
    //bpf_printk("WhiteTable %x , reg: %d", key, reg); 
}


// Функция записи статистики принятых, сброшенных и направленных обратно пакетов
void stat_white(int pass, int drop, int tx){
    int key = 0;
    __u64 kpass = 0;
    __u64 kdrop = 0;
    __u64 ktx   = 0;
    struct StatData *stat = bpf_map_lookup_elem(&stat_map, &key);

    if(stat){
        kpass = stat->KPass;
        kdrop = stat->KDrop;
        ktx   = stat->KTx;
    }

    struct StatData new_stat;
    
    if(pass) {
        new_stat.KPass = kpass + 1;
        new_stat.KDrop = kdrop;
        new_stat.KTx   = ktx;
    }
    else if(drop){
        new_stat.KPass = kpass;
        new_stat.KDrop = kdrop + 1;
        new_stat.KTx   = ktx;
    }
    else if(tx){
        new_stat.KPass = kpass;
        new_stat.KDrop = kdrop;
        new_stat.KTx   = ktx + 1;
    }
    else{
        new_stat.KPass = kpass;
        new_stat.KDrop = kdrop;
        new_stat.KTx   = ktx;
    }

    bpf_map_update_elem(&stat_map, &key, &new_stat, BPF_ANY);
    
    //bpf_printk("pass %d, drop: %d", new_stat.KPass, new_stat.KDrop); 
}


// Главня функция программы XDP
SEC("prog")
int xdp_main(struct xdp_md *ctx) {
    struct NetPacket Npack;
    Npack.ctx = ctx;
    Npack.eth = (struct ethhdr*)(void*)ctx->data;
    
    // В случае если это не Ethernet кадр, то пропустить
    if((void*)(Npack.eth + 1) > (void*)ctx->data_end) {
        return XDP_PASS;
    }

    // Проверяем, есть ли в кадре Ethernet пакет IPv4, если нет, то пропускаем
    if(Npack.eth->h_proto != bpf_ntohs(ETH_P_IP)){
        return XDP_PASS;
    }
    
    // Проверяем на корректный доступ к информации об IP
    struct iphdr* ipv4 = (struct iphdr*)(Npack.eth + 1);
    if((void*)(ipv4 + 1) > (void*)Npack.ctx->data_end) {
        return XDP_DROP;            // не корректные пакеты сбрасываем
    }
    Npack.ipv4 = ipv4;

    // Проверяем задан ли для пакета протокол TCP, если нет, то пропускаем 
    if(Npack.ipv4->protocol != IPPROTO_TCP) {
        return XDP_PASS;
    }

    // Проверяем на корректный доступ к информации о протоколе TCP
    struct tcphdr* tcp = (struct tcphdr*)(Npack.ipv4 + 1);
    if((void*)(tcp + 1) > (void*)Npack.ctx->data_end) {
        return XDP_DROP;            // не корректные пакеты сбрасываем
    }
    Npack.tcp = tcp; 

    // Проверяем с какого порта пришёл пакет, если с прослушиваемых портов, то начинаем его обработку
    if ((bpf_ntohs(Npack.tcp->dest) == 80) || (bpf_ntohs(Npack.tcp->dest) == 443)) {
        // Считываем уровень доверия для клиента в белом списке
        __s16 *reg = bpf_map_lookup_elem(&white_table_map, &Npack.ipv4->saddr);

        // Если считать удалось и он больше 0
        if(reg && (*reg > 0)) {
            // То в случае если клиент инициализирует 3е рукопожатие
            // Понижаем его уровень доверия на еденицу
            // А также отправляем ему обратно стандартный SYN-ACK ответ
            // И далее все пакеты от него пропускаем
            
            if(Npack.tcp->syn) {
                __s16 new_reg = *reg - 1;
                //bpf_printk("new_reg %d ", new_reg);

                write_white_table(new_reg, Npack.ipv4->saddr);

                // Формируем стандартный SYN-ACK ответ
                Npack.tcp->ack_seq = bpf_htonl(bpf_ntohl(tcp->seq) + 1);
                Npack.tcp->seq = 0;
                Npack.tcp->ack = 1;

                // Меняем местами порт источника и порт назначения
                __u16 temp_sport = Npack.tcp->source;
                Npack.tcp->source = Npack.tcp->dest;
                Npack.tcp->dest = temp_sport;

                // Меняем местами IP адрес источника и адрес назначения
                __u32 temp_saddr = Npack.ipv4->saddr;
                Npack.ipv4->saddr = Npack.ipv4->daddr;
                Npack.ipv4->daddr = temp_saddr;

                // Изменяем направление Ethernet пакета
                struct ethhdr temp_eth = *Npack.eth;
                memcpy(Npack.eth->h_dest, temp_eth.h_source, ETH_ALEN); 
                memcpy(Npack.eth->h_source, temp_eth.h_dest, ETH_ALEN);
                
                stat_white(0, 0, 1);
                return XDP_TX;
            }
            else{
                stat_white(1, 0, 0);
                return XDP_PASS;
            }
        }
        else {
            // Если же клиента нет в белом списке или его уровень доверия равен нулю,
            // то начинаем процесс его проверки

            if(Npack.tcp->syn) {
                //Вычисляем хэш куки для дальнейшей проверки
                __u32 hash = hash_tcp_ip(Npack.ipv4->saddr, Npack.ipv4->daddr, Npack.tcp->source, Npack.tcp->dest, bpf_ntohl(Npack.tcp->seq) - 1);
                __u32 cookie = hash_cookie(hash, bpf_ntohl(Npack.tcp->seq) - 1);

                //bpf_printk("cookie %x     seq: %x", cookie, bpf_ntohl(Npack.tcp->seq)); 

                write_hash_table(cookie, Npack.ipv4->saddr);
    
                // Формируем SYN-ACK ответ с вычислиными куки
                Npack.tcp->ack_seq = bpf_htonl(bpf_ntohl(tcp->seq) + 1);
                Npack.tcp->seq = bpf_htonl(cookie);
                Npack.tcp->ack = 1;

                // Меняем местами порт источника и порт назначения
                __u16 temp_sport = Npack.tcp->source;
                Npack.tcp->source = Npack.tcp->dest;
                Npack.tcp->dest = temp_sport;

                // Меняем местами IP адрес источника и адрес назначения
                __u32 temp_saddr = Npack.ipv4->saddr;
                Npack.ipv4->saddr = Npack.ipv4->daddr;
                Npack.ipv4->daddr = temp_saddr;

                // Изменяем направление Ethernet пакета
                struct ethhdr temp_eth = *Npack.eth;
                memcpy(Npack.eth->h_dest, temp_eth.h_source, ETH_ALEN); 
                memcpy(Npack.eth->h_source, temp_eth.h_dest, ETH_ALEN);

                stat_white(0, 0, 1);
                return XDP_TX;
            }
            else if(Npack.tcp->ack) {
                // Считываем из хэш таблицы хэш для адреса с которого пришёл пакет
                __u32 *cookie_table = bpf_map_lookup_elem(&hash_table_map, &Npack.ipv4->saddr);

                // В случае если хэш считать удалось
                if (cookie_table) {
                    // То сравниваем его с тем, что прислал клиент
                    // И если они совпадают, то заносим клиента в белый список, 
                    // а также присваеваем ему уровень доверия равный 100 и пропускаем пакет
                    // иначе сбрасываем

                    __u32 cookie_client = bpf_ntohl(Npack.tcp->ack_seq) - 1;

                    if (cookie_client == *cookie_table){
                        __s16 reg = 100;

                        //bpf_printk("cookie_table %x ", *cookie_table);
                        write_white_table(reg, Npack.ipv4->saddr);

                        stat_white(1, 0, 0);
                        return XDP_PASS;
                    }

                    stat_white(0, 1, 0);
                    return XDP_DROP;  
                }

                stat_white(0, 1, 0);
                return XDP_DROP;            
            }
            else {
                stat_white(0, 1, 0);
                return XDP_DROP;
            }
        }
    }
    
    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
