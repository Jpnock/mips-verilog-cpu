# TODO: Not a deliverable.

set -euo pipefail

l="\033[34;1m"
ll="\033[0m"

TEST_FILES="rtl/**/*_tb.v"

for file in $TEST_FILES; do

    # TB Name
    TB_NAME=$(basename $file)
    TB_NAME=$(echo ${TB_NAME%.*})

    # Logging/Output Files
    out="./bin/$(basename $TB_NAME).out"
    outlog="./bin/$(basename $TB_NAME).log"

    printf "$l▶$ll Building Test: $(basename $TB_NAME)\n" $

    # Build TB
    iverilog -DDEBUG -Wall -g 2012 rtl/**/*.v rtl/*.v \
        -pfileline=1 \
        -s $TB_NAME \
        -o "$out" 2>&1 | sed 's/^/  /'

    printf "$l ...$ll Built!\n"

    # Run
    printf "$l▶$ll Running Test: $(basename $TB_NAME)\n" $
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

    printf "$l ...$ll Passed!\n"

done
