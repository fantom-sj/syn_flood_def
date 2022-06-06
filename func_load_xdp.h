/*
	В данном файле реализованы функции, необхадимые для загрузки программы XDP
	для работы в исполняемой виртуальной машине eBPF.
	Данные функции были взяты из учебных проектов xdp-tutorial,
	а также немного переработаны в ходе их изучения.

*/


struct config cfg = {
	.xdp_flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE,
	.ifindex   = -1,
	.do_unload = false,
};


struct bpf_map_info info = { 0 };


static const struct option_wrapper long_options[] = {
	{{"help",        no_argument,		NULL, 'h' },
	 "Показать справку.", false},

	{{"dev",         required_argument,	NULL, 'd' },
	 "Сетевой интерфейс <ifname>, на котором будет запущена программа XDP.", "<ifname>", true},

	{{"skb-mode",    no_argument,		NULL, 'S' },
	 "Установите программу XDP в режиме SKB."},

	{{"native-mode", no_argument,		NULL, 'N' },
	 "Установите программу XDP в нативном режиме."},

	{{"auto-mode",   no_argument,		NULL, 'A' },
	 "Автоматичесик подобрать режим установки."},

	{{"force",       no_argument,		NULL, 'F' },
	 "Установка с принудительной заменой установленной программы в интерфейсе."},

	{{"unload",      no_argument,		NULL, 'U' },
	 "Выгрузить программу XDP."},

	{{"quiet",       no_argument,		NULL, 'q' },
	 "Тихий режим (без вывода)"},

	{{0, 0, NULL,  0 }}
};


struct bpf_object *load_bpf_object_file(const char *filename) {
	__u32 info_len = sizeof(info);

	int first_prog_fd = -1;
	struct bpf_object *obj;
	int err;

	err = bpf_prog_load(filename, BPF_PROG_TYPE_XDP, &obj, &first_prog_fd);
	
	if (err) {
		fprintf(stderr, "ОШИБКА: не удалась загрузка файла BPF-OBJ (%s) (%d): %s\n",
			filename, err, strerror(-err));
		return NULL;
	}
	
	err = xdp_link_attach(cfg.ifindex, cfg.xdp_flags, first_prog_fd);
	
	if (err)
		return NULL;

	err = bpf_obj_get_info_by_fd(first_prog_fd, &info, &info_len);
	if (err) {
		fprintf(stderr, "ERR: не могу получить информацию о программе - %s\n",
			strerror(errno));
		return NULL;
	}

	return obj;
}

static int xdp_link_detach(int ifindex, __u32 xdp_flags) {
	int err;

	if ((err = bpf_set_link_xdp_fd(ifindex, -1, xdp_flags)) < 0) {
		fprintf(stderr, "ОШИБКА: не удалось выгрузить набор ссылок XDP (err = %d):%s\n",
			err, strerror(-err));
		return EXIT_FAIL_XDP;
	}
	return EXIT_OK;
}

int xdp_link_attach(int ifindex, __u32 xdp_flags, int prog_fd) {
	int err = bpf_set_link_xdp_fd(ifindex, prog_fd, xdp_flags);

	if (err == -EEXIST && !(xdp_flags & XDP_FLAGS_UPDATE_IF_NOEXIST)) {
		__u32 old_flags = xdp_flags;

		xdp_flags &= ~XDP_FLAGS_MODES;
		xdp_flags |= (old_flags & XDP_FLAGS_SKB_MODE) ? XDP_FLAGS_DRV_MODE : XDP_FLAGS_SKB_MODE;
		err = bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
		if (!err)
			err = bpf_set_link_xdp_fd(ifindex, prog_fd, old_flags);
	}
	

	if (err < 0) {
		fprintf(stderr, "ОШИБКА: "
			"ifindex(%d) - неудалось получить ссылку на файловый дискриптор XDP (%d): %s\n",
			ifindex, -err, strerror(-err));

		switch (-err) {
		case EBUSY:
		case EEXIST:
			fprintf(stderr, "Подсказка: XDP уже загружен на устройство"
				" используйте --force замены программы\n");
			break;
		case EOPNOTSUPP:
			fprintf(stderr, "Подсказка: Нативный режим XDP не поддерживается"
				" используйте --skb-mode или --auto-mode\n");
			break;
		default:
			break;
		}
		return EXIT_FAIL_XDP;
	}

	return EXIT_OK;
}


static int __check_map_fd_info(int map_fd, struct bpf_map_info *info,
			       struct bpf_map_info *exp) {
	__u32 info_len = sizeof(*info);
	int err;

	if (map_fd < 0)
		return EXIT_FAIL;

	err = bpf_obj_get_info_by_fd(map_fd, info, &info_len);
	if (err) {
		fprintf(stderr, "ОШИБКА: %s() не удаётся получить информацию - %s\n",
			__func__,  strerror(errno));
		return EXIT_FAIL_BPF;
	}

	if (exp->key_size && exp->key_size != info->key_size) {
		fprintf(stderr, "ОШИБКА: %s() "
			"Размер ключа (%d) не соответствует ожидаемому размеру (%d)\n",
			__func__, info->key_size, exp->key_size);
		return EXIT_FAIL;
	}

	if (exp->value_size && exp->value_size != info->value_size) {
		fprintf(stderr, "ОШИБКА: %s() "
			"Размер значения карты (%d) не соответствует ожидаемому размеру (%d)\n",
			__func__, info->value_size, exp->value_size);
		return EXIT_FAIL;
	}

	if (exp->max_entries && exp->max_entries != info->max_entries) {
		fprintf(stderr, "ERR: %s() "
			"Максимальное количество записей сопоставления (%d) не соответствует ожидаемому размеру (%d)\n",
			__func__, info->max_entries, exp->max_entries);
		return EXIT_FAIL;
	}
	
	if (exp->type && exp->type  != info->type) {
		fprintf(stderr, "ERR: %s() "
			"Тип карты (%d) не соответствует ожидаемому типу (%d)\n",
			__func__, info->type, exp->type);
		return EXIT_FAIL;
	}

	return 0;
}
