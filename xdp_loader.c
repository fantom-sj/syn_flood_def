#include <bpf/bpf.h>
#include <bpf/libbpf.h>

#include <linux/ip.h>
#include <net/if.h>
#include <linux/if_link.h>

#include <errno.h>
#include <malloc.h>

#include "../common/common_params.h"
#include "func_load_xdp.h"
#include "hash_cookie.h"
#include "common_struct.h"


int find_map_fd(struct bpf_object *bpf_obj, const char *mapname) {
	struct bpf_map *map;
	int map_fd = -1;

	map = bpf_object__find_map_by_name(bpf_obj, mapname);
        if (!map) {
		fprintf(stderr, "ОШИБКА: не удается найти карту данных: %s\n", mapname);
		return map_fd;
	}

	map_fd = bpf_map__fd(map);
	printf("Успешно: Карта с md_map(%d) найдена!\n", map_fd);
	return map_fd;
}


static void Read_map(int map_fd) {
	__u32 key = 0, next_key = 0;

	while (true) {
		struct DataCookie value;
		
		bpf_map_get_next_key(map_fd, &key, &next_key);
		
		if(errno != ENOENT){
			bpf_map_lookup_and_delete_elem(map_fd, &key, &value);

			printf("key: %x, daddr: %x, seqnum: %d, time: %x\n", 
					key, value.saddr, value.seqnum, value.time);
		}

		key = next_key;
		
		//usleep(50000);
	}
}


int main(int argc, char **argv) {
	// Файл и объект программы BPF
	char filename[256] = "xdp_kern.o";
	struct bpf_object *bpf_obj;

	parse_cmdline_args(argc, argv, long_options, &cfg, "Программа для загрузки bpf кода в ядро и обработки карт!");
	
	
	if (cfg.ifindex == -1) {
		fprintf(stderr, "ОШИБКА: обязательная опция --dev отсутствует\n");
		usage(argv[0], "Запустить xdp!", long_options, (argc == 1));
		return EXIT_FAIL_OPTION;
	}
	if (cfg.do_unload)
		return xdp_link_detach(cfg.ifindex, cfg.xdp_flags);

	bpf_obj = load_bpf_object_file(filename);
	if (bpf_obj) {
		printf("Успешная загрузка"
	       "программы XDP: %s(id:%d) для работы в интерфейсе: %s(ifindex:%d)\n",
	       info.name, info.id, cfg.ifname, cfg.ifindex);
	}
	else{
		fprintf(stderr, "ОШИБКА: не удалась загрузка файла: %s\n", filename);
		return EXIT_FAIL_BPF;
	}

	int map_fd = find_map_fd(bpf_obj, "data_cookis_map");
	if (map_fd < 0) {
		xdp_link_detach(cfg.ifindex, cfg.xdp_flags);
		return EXIT_FAIL_BPF;
	}

	Read_map(map_fd);
	return EXIT_OK;
}
