#include <linux/bpf.h>
#include <bpf/bpf_endian.h>
#include <bpf/bpf_helpers.h>

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/in.h>

#include "common_struct.h"
#include "hash_cookie.h"

#define MAX_CSUM_BYTES 64

// Структура для сохранения сетевого пакета
struct NetPacket{
    struct xdp_md* ctx;
    struct iphdr* ipv4;      // структура для хранения IP заголовка пакета
    struct tcphdr* tcp;      // TCP заголовок
    struct ethhdr* eth;      // заголовок Ethernet-кадра
};


struct bpf_map_def SEC("maps") white_table_map = {
    .type = BPF_MAP_TYPE_ARRAY,
    .key_size = sizeof(__u32),
    .value_size = sizeof(struct DataCookie),
    .max_entries = 1024,
};


struct bpf_map_def SEC("maps") hash_table_map = {
    .type = BPF_MAP_TYPE_HASH,
    .key_size = sizeof(__u32),
    .value_size = sizeof(struct HashTable),
    .max_entries = 1024,
};


__u32 cookie_counter() {
    return bpf_ktime_get_ns() >> (10 + 10 + 10 + 3); /* 8.6 sec */
} 


/*void write_data_table(struct DataCookie *data){
    __u32 key = data->saddr; 

    bpf_map_update_elem(&data_cookis_map, &key, data, BPF_EXIST);
}*/


void write_hash_table(struct HashTable *data){
    __u32 key = data->saddr;

    bpf_map_update_elem(&hash_table_map, &key, data, BPF_ANY);
    bpf_printk("Uspeshno dobavili %x\n     key: %d", data->cookie, key);
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

    // Проверяем с какого порта пришёл пакет, если с прослушиваемых портов, то просматриваем флаги
    if ((bpf_ntohs(Npack.tcp->dest) == 80) || (bpf_ntohs(Npack.tcp->dest) == 443)) {
        if(Npack.tcp->syn) {    
            __u32 hash = hash_tcp_ip(Npack.ipv4->saddr, Npack.ipv4->daddr, Npack.tcp->source, Npack.tcp->dest, bpf_ntohl(Npack.tcp->seq) - 1);
            __u32 cookie = hash_cookie(hash, bpf_ntohl(Npack.tcp->seq) - 1, cookie_counter());
            
            struct HashTable data;
            data.saddr = Npack.ipv4->saddr;
            data.cookie = cookie;
            
            write_hash_table(&data);

            // Приступаем к формированию SYN-ACK, который пошлём обратно
            Npack.tcp->ack_seq = bpf_htonl(bpf_ntohl(Npack.tcp->seq) + 1);
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
            memcpy(Npack.eth->h_source, temp_eth.h_dest, ETH_ALEN);ы
            
            return XDP_TX;
        }
        else if(Npack.tcp->ack) {
            return XDP_PASS;
        }
        else {
            return XDP_PASS;
        }
    }
    
    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
