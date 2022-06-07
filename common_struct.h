struct DataCookie {
    __u32 saddr;            // IP-адрес источника
    __u32 daddr;            // IP-адрес назначения
    __u16 sport;            // TCP-порт источника
    __u16 dport;            // TCP-порт назначения
    __u32 seqnum;           // Порядковый номер
    __u64 time;             // Время с начала запуска программы
};

struct HashTable {
    __u32 saddr;            // IP-адрес источника
    __u32 cookie;           // Хэш-Куки
};

struct WhiteTable {
    __u32 saddr;            // IP-адрес источника
};

