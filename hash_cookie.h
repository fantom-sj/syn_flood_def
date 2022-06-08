/*
 * Функции для вычисления хэш куки
 */

#include <sys/time.h>

#define GOLDEN_RATIO_32 0x61C88647


// Получаем сид на основе времени от начала запуска программы
__u32 get_seed() {
    __u32 sec = (bpf_ktime_get_ns() << 24) >> 24;
    
    //bpf_printk("sec %x ", sec);
    return sec ^ GOLDEN_RATIO_32;
}


// Вычисляем хэш
__u64 hash_sum(const __u64 buf, __u16 sid) {
    __u64 hash = buf * GOLDEN_RATIO_32;
    return hash >> sid;
}


// Расчитываем хэш для основных параметров TCP IP
__u32 hash_tcp_ip(__u32 saddr, __u32 daddr, __u16 sport, __u16 dport, __u32 seqnum) {
    __u32 cookie_seed = get_seed();

    __u64 res = hash_sum(((__u64)daddr << 32) | saddr, cookie_seed);

    return hash_sum(((__u64)dport << 48) | ((__u64)seqnum << 16) | (__u64)sport, res);
}


// Создаём куки из хэша
__u32 hash_cookie(__u32 hash, __u32 seqnum) {
    __u32 hash_seed = get_seed();

    return (__u32)(seqnum + hash_sum(hash, hash_seed));
}