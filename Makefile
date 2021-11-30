SHELL := bash -euo pipefail

.PHONY: all clean build build-tests test run

M := $(shell printf "\033[34;1m▶\033[0m")
BUILD_CMD := iverilog -pfileline=1 -DDEBUG -Wall -g 2012 rtl/**/*.v rtl/*.v

all: clean build build-tests test

clean:
	@rm -f bin/*

build:
	@printf "\033[34;1m▶\033[0m Building\n"
	@mkdir -p bin
	@iverilog -pfileline=1 -DDEBUG -Wall -g 2012 rtl/mips_cpu/package.v rtl/mips_cpu/!(package).v rtl/*.v -o bin/mips_cpu.out 2>&1 | sed 's/^/  /'
	@printf "\033[34;1m ...\033[0m built\n"

build-tests:
	@printf "\033[34;1m▶\033[0m Assembling tests\n"
	@(cd test; ./build_instruction_testbench.sh)
	@printf "\033[34;1m ...\033[0m assembled\n"

test:
	@mkdir -p bin
	@printf "\033[34;1m▶\033[0m Running Verilog testbenches\n\n"
	@./test/run_submodule_testbench.sh
	@printf "\n\033[34;1m...\033[0m Verilog testbenches passed\n"
	@printf "\n\033[34;1m▶\033[0m Running ASM testbenches\n\n"
	@./test/test_mips_cpu_bus.sh rtl
	@printf "\n\033[34;1m ...\033[0m ASM testbenches passed\n"

run:
	@printf "\033[34;1m▶\033[0m Running ./bin/mips_cpu.out\n"
	@./bin/mips_cpu.out > ./bin/mips_cpu.log || (cat ./bin/mips_cpu.log; exit 1;)
	@printf "\033[34;1m ...\033[0m Executed successfully\n"
