.PHONY: all clean build test run

M := $(shell printf "\033[34;1m▶\033[0m")
BUILD_CMD := iverilog -Wall -g 2012 rtl/**/*.v rtl/*.v

all: clean build test run

clean:
	@rm -f bin/*

build:
	@mkdir -p bin
	@$(BUILD_CMD) -o bin/mips_cpu

TESTFILES := $(wildcard rtl/**/*_tb.v) $(wildcard rtl/*_tb.v)
test:
	@mkdir -p bin
	@for t in $(TESTFILES); do \
		tb=$${t##*/}; \
		tb=$${tb%.v}; \
		out="bin/$$tb.out"; \
		outlog="bin/$$tb.log"; \
		printf "\033[34;1m▶\033[0m testing %s\n" $$tb; \
		$(BUILD_CMD) -s "$$tb" -o "$$out"; \
		./$$out > "$$outlog"; \
		grep "ERROR:" "$$outlog" > /dev/null && \
			printf "\033[34;1m ...\033[0m failed %s\n" && \
			cat "$$outlog" && \
			exit 1; \
		printf "\033[34;1m ...\033[0m passed\n"; \
	done;



run:
	@./bin/mips_cpu > /dev/null
	@echo "Executed successfully"
