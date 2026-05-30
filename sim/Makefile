SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += $(PWD)/../rtl/mac_unit.sv
TOPLEVEL = mac_unit
MODULE = mac_tb
COMPILE_ARGS += -DSIM_DUMP
include $(shell cocotb-config --makefiles)/Makefile.sim
