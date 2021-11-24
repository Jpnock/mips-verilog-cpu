SHELL := bash -euo pipefail

.PHONY: all clean build test run

M := $(shell printf "\033[34;1m▶\033[0m")
BUILD_CMD := iverilog -DDEBUG -Wall -g 2012 rtl/**/*.v rtl/*.v

all: clean build test

clean:
	@rm -f bin/*

build:
	@printf "\033[34;1m▶\033[0m Building\n"
	@mkdir -p bin
	@$(BUILD_CMD) -o bin/mips_cpu.out 2>&1 | sed 's/^/  /'
	@printf "\033[34;1m ...\033[0m built\n"

TESTFILES := $(wildcard rtl/**/*_tb.v) $(wildcard rtl/*_tb.v)
test:
	@mkdir -p bin
	@for t in $(TESTFILES); do \
		(./test/run_verilog_testbench.sh "$$t" || exit 1); \
	done;

run:
	@printf "\033[34;1m▶\033[0m Running ./bin/mips_cpu.out\n"
	@./bin/mips_cpu.out > ./bin/mips_cpu.log || (cat ./bin/mips_cpu.log; exit 1;)
	@printf "\033[34;1m ...\033[0m Executed successfully\n"
