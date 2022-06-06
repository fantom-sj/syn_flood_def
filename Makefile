# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

# Departing from the implicit _user.c scheme
XDP_TARGETS  := xdp_kern
USER_TARGETS := xdp_loader
USER_TARGETS_CPP := user_prog

LIBBPF_DIR = ../libbpf/src/
COMMON_DIR = ../common/

include $(COMMON_DIR)/common.mk
COMMON_OBJS := $(COMMON_DIR)/common_params.o
