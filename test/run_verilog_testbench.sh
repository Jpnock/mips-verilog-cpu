# TODO: Remove debug outputs.

set -euo pipefail

l="\033[34;1m"
ll="\033[0m"

SOURCE_DIR=${1:-rtl}
TEST_INSTR=${2:-all}
TEST_FILES=$([[ "$TEST_INSTR" == "all" ]] && echo "test/mips/all/*.asm" || echo "test/mips/all/*_${TEST_INSTR}_*.asm")

for file in $TEST_FILES; do

    # Logging/Output Files
    out="./bin/$(basename $file).out"
    outlog="./bin/$(basename $file).log"

    # Extract Expected Value
    read -r expected_value <$file
    expected_value=$(echo $expected_value | sed 's/^.*Expect: //')

    printf "$l▶$ll Building Test: $(basename $file)\n" $

    #Build TB
    iverilog -DDEBUG -Wall -g 2012 ${SOURCE_DIR}/**/*.v ${SOURCE_DIR}/*.v \
        -s mips_cpu_bus_tb \
        -P mips_cpu_bus_tb.EXPECTED_VALUE="$expected_value" \
        -P mips_cpu_bus_tb.RAM_FILE=\"${file}.hex\" \
        -o "$out" 2>&1 | sed 's/^/  /'

    printf "$l...$ll Built!\n"

    printf "$l▶$ll Running Test: $(basename $file)\n" $

    # Run
    ./$out >"${outlog}" 2>&1 || (
        cat "${outlog}" | sed 's/^/  /'
        exit 1
    )

    # Error
    grep -q -i "Error:" "${outlog}" >/dev/null && (
        cat "${outlog}" | sed 's/^/  /'
        printf "$l ...$ll failed %s\n"
        exit 1
    )

    printf "$l...$ll Passed!\n"

done
