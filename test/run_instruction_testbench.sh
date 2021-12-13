#!/bin/bash

set -uo pipefail

SOURCE_DIR=${1:-rtl}
TEST_INSTR=${2-}
TEST_WAIT=${3:-1}
TEST_FILES=$([[ -z "$TEST_INSTR" ]] && find test/mips/** -type f \( -iname \*.asm -o -iname \*.c \) 2> /dev/null || find "test/mips/${TEST_INSTR}" -type f \( -iname \*.asm -o -iname \*.c \) 2> /dev/null)
if [[ $? -ne 0 ]]; then
    # No test files found
    exit 0;
fi

EXIT_CODE=0

for file in $(echo "$TEST_FILES" | sort); do
    EXTRA_ARGS=""

    base_name=$(basename $file)
    dir_name=$(basename $(dirname $file))
    unique_name="${dir_name}_${base_name%.*}"

    mkdir -p ./test/bin

    # Logging/Output Files
    out="./test/bin/${unique_name}.out"
    buildlog="./test/bin/${unique_name}.build.log"
    testlog="./test/bin/${unique_name}.test.log"

    fail_file() {
        echo "${unique_name} ${dir_name} Fail # $1"
        EXIT_CODE=1
    }

    # Extract Expect Value
    expected_value=$(head -n 1 "$file" | sed -n -e 's/^\(#\|\/\/\) Expect: //p')
    if [[ -z $expected_value ]]; then
        fail_file "Did not find expected value in test case"
        continue
    fi

    EXTRA_ARGS=$(head -n 2 "$file" | sed -n -e 's/^\(#\|\/\/\) Args: //p')

    #Build TB
    iverilog ${EXTRA_ARGS} -Wall -g 2012 \
        ${SOURCE_DIR}/mips_cpu/*.v ${SOURCE_DIR}/mips_cpu_*.v ./test/rtl/*.v \
        -pfileline=1 \
        -s mips_cpu_bus_tb \
        -P mips_cpu_bus_tb.EXPECTED_VALUE="$expected_value" \
        -P mips_cpu_bus_tb.RAM_FILE=\"${file}.hex\" \
        -P mips_cpu_bus_tb.RAM_WAIT="$TEST_WAIT" \
        -o "$out" >"${buildlog}" 2>&1
    if [[ $? -ne 0 ]]; then
        fail_file "Failed to build test bench"
        continue
    fi

    # Run
    timeout 15s ./$out >"${testlog}" 2>&1
    if [[ $? -ne 0 ]]; then
        fatal=$(grep -i -m 1 "Testbench expected 0x" "${testlog}" | tr -d '\n')
        if [[ $? -ne 0 ]]; then
            fatal=$(grep -m 1 "FATAL: " "${testlog}" | tr -d '\n')
        fi
        fail_file "Test bench exited with non-zero status code: ${fatal}"
        continue
    fi

    # Error
    grep -q -i -v "^ERROR:" "${testlog}" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        fail_file "Test bench found 'ERROR:' within log output"
        continue
    fi

    echo "${unique_name} ${dir_name} Pass"
done

exit ${EXIT_CODE}
