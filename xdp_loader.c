/*
 * Программы загрузчик, которая позволяет загрузить байт код в машину eBPF.
 * А также позволяет просматривать статистику работы программы в реальном времени
 */

#include <bpf/bpf.h>
#include <bpf/libbpf.h>

#include <linux/ip.h>
#include <net/if.h>
#include <linux/if_link.h>

#include <errno.h>
#include <malloc.h>

#include "../common/common_params.h"
#include "func_load_xdp.h"
#include "common_struct.h"


// Функция поиска карты с данными для считывания статистики
int find_map_fd(struct bpf_object *bpf_obj, const char *mapname) {
	struct bpf_map *map;
	int map_fd = -1;

	map = bpf_object__find_map_by_name(bpf_obj, mapname);
        if (!map) {
		fprintf(stderr, "ОШИБКА: не удается найти карту данных: %s\n", mapname);
		return map_fd;
	}

	map_fd = bpf_map__fd(map);
	printf("Карта со статистикой найдена и успешно подключена!\n", map_fd);
	return map_fd;
}


// Функция считывания данных из карты статистики
static void Read_map(int map_fd) {
	int key = 0;
	struct StatData stat;
	stat.KDrop = 0;
	stat.KPass = 0;
	stat.KTx   = 0;

	printf("\n-----------Статистика по принятым и обработанным пакетам-----------\n");
	__u64 all = stat.KPass + stat.KDrop + stat.KTx;

	while (true) {
		bpf_map_lookup_elem(map_fd, &key, &stat);
		printf("Пропущено %d; Сброшено: %d; Перенаправлено в ответ: %d; Всего: %d \033[2000E\033[1F\n", 
				stat.KPass, stat.KDrop, stat.KTx, all);
	}
}


// Главная функция загрузчика
int main(int argc, char **argv) {

	// Файл и объект программы BPF
	char filename[11] = "xdp_kern.o";
	char map_name[9] = "stat_map";
	struct bpf_object *bpf_obj;

	printf("\n");
	printf("/------------------------------------------------------------------------------/\n");
	printf("/        Программа для загрузки кода в машину eBPF и сбора статистики!         /\n");
	printf("/------------------------------------------------------------------------------/\n\n");
	
	char *help = "Для запуска программы используйте следующие опции: \n";
	parse_cmdline_args(argc, argv, long_options, &cfg, help);
	
	if (cfg.ifindex == -1) {
		fprintf(stderr, "ОШИБКА: обязательная опция --dev отсутствует\n");
		usage(argv[0], help, long_options, (argc == 1));
		return EXIT_FAIL_OPTION;
	}
	if (cfg.do_unload)
		return xdp_link_detach(cfg.ifindex, cfg.xdp_flags);

	bpf_obj = load_bpf_object_file(filename);
	if (bpf_obj) {
		printf("Успешная загрузка программы XDP для работы на интерфейсе: %s\n", cfg.ifname);
	}
	else{
		fprintf(stderr, "ОШИБКА: не удалась загрузка файла: %s\n", filename);
		return EXIT_FAIL_BPF;
	}

	int map_fd = find_map_fd(bpf_obj, map_name);
	if (map_fd < 0) {
		xdp_link_detach(cfg.ifindex, cfg.xdp_flags);
		return EXIT_FAIL_BPF;
	}

	Read_map(map_fd);
	return EXIT_OK;
}
