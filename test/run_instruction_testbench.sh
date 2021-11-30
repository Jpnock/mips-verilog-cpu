# TODO: Remove debug outputs.

set -uo pipefail
shopt -s extglob

SOURCE_DIR=${1:-rtl}
TEST_INSTR=${2-}
TEST_FILES=$([[ -z "$TEST_INSTR" ]] && echo "test/mips/**/*.asm" || echo "test/mips/${TEST_INSTR}/*.asm")

EXIT_CODE=0

for file in $TEST_FILES; do
    base_name=$(basename $file)
    dir_name=$(basename $(dirname $file))
    unique_name="${dir_name}_${base_name%.asm}"

    mkdir -p ./bin

    # Logging/Output Files
    out="./bin/$(basename $file).out"
    buildlog="./bin/$(basename $file).build.log"
    testlog="./bin/$(basename $file).test.log"

    fail_file() {
        echo "${unique_name} ${dir_name} Fail"
        EXIT_CODE=1
    }

    # Extract Expected Value
    expected_value=$(head -n 1 "$file" | sed -n -e 's/^# Expect: //p')
    if [[ -z $expected_value ]]; then
        fail_file
        continue
    fi

    #Build TB
    if [[ -f ${SOURCE_DIR}/mips_cpu/package.v ]]; then
        iverilog -DDEBUG -Wall -g 2012 \
            ${SOURCE_DIR}/mips_cpu/package.v ${SOURCE_DIR}/mips_cpu/!(package).v ${SOURCE_DIR}/*.v \
            -pfileline=1 \
            -s mips_cpu_bus_tb \
            -P mips_cpu_bus_tb.EXPECTED_VALUE="$expected_value" \
            -P mips_cpu_bus_tb.RAM_FILE=\"${file}.hex\" \
            -o "$out" >"${buildlog}" 2>&1
        if [[ $? -ne 0 ]]; then
            fail_file
            continue
        fi
    else
        iverilog -DDEBUG -Wall -g 2012 \
            ${SOURCE_DIR}/mips_cpu/*.v ${SOURCE_DIR}/mips_cpu_*.v \
            -pfileline=1 \
            -s mips_cpu_bus_tb \
            -P mips_cpu_bus_tb.EXPECTED_VALUE="$expected_value" \
            -P mips_cpu_bus_tb.RAM_FILE=\"${file}.hex\" \
            -o "$out" >"${buildlog}" 2>&1
        if [[ $? -ne 0 ]]; then
            fail_file
            continue
        fi
    fi

    # Run
    timeout 15s ./$out >"${testlog}" 2>&1
    if [[ $? -ne 0 ]]; then
        fail_file
        continue
    fi

    # Error
    # TODO: maybe remove this before submission?
    grep -q -i -v "^ERROR:" "${testlog}" >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        fail_file
        continue
    fi

    echo "${unique_name} ${dir_name} Pass"
done

exit ${EXIT_CODE}
