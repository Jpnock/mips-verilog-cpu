.PHONY: all clean build run

all: clean build run

clean: 
	@rm -f bin/mips_cpu

build: 
	@iverilog -Wall -g 2012 -o bin/mips_cpu rtl/**/*.v

run:
	@(./bin/mips_cpu && echo "Executed successfully") || echo "Execution failed with code $$?"
