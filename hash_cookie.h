#define GOLDEN_RATIO_32 0x61C88647



// Вычисляем хэш размера 32 бита
__u32 hash_32(const __u32 buf, __u16 size) {
    __u32 hash = buf * GOLDEN_RATIO_32;
    return hash >> (32 - size);
}


// Расчитываем хэш для основных параметров TCP IP
__u32 hash_tcp_ip(__u32 saddr, __u32 daddr, __u16 sport, __u16 dport, __u32 seqnum) {
    __u32 cookie_seed = 0xFD127A8E;
    __u32 res = hash_32(((__u64)daddr << 32) | saddr, cookie_seed);

    return hash_32(((__u64)dport << 48) | ((__u64)seqnum << 16) | (__u64)sport, res);
}

// Создаём куки из хэша
__u32 hash_cookie(__u32 hash, __u32 seqnum, __u32 count) {
    return seqnum + hash_32(hash, count);
}


// Сравниваем куки
int verify_cookies(__u32 hash, __u32 seqnum, __u32 cookie, __u32 count) {
    cookie -= seqnum;
    
    return cookie == hash_32(hash, count);
}