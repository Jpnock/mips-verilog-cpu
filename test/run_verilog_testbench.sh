set -euo pipefail

l="\033[34;1m"
ll="\033[0m"

tb_name=${1##*/}
tb_name=${tb_name%.v}

out="./bin/${tb_name}.out"
outlog="./bin/${tb_name}.log"

printf "$l▶$ll building test: ${tb_name}\n" $

iverilog -DDEBUG -Wall -g 2012 rtl/**/*.v rtl/*.v -s "${tb_name}" -o "$out" 2>&1 | sed 's/^/  /'

printf "$l...$ll built\n"

printf "$l▶$ll running test: ${tb_name}\n" $

./$out > "${outlog}" 2>&1 || (cat "${outlog}" | sed 's/^/  /'; exit 1)

grep -q -i "error:" "${outlog}" > /dev/null && (cat "${outlog}" | sed 's/^/  /'; printf "$l ...$ll failed %s\n"; exit 1;)

printf "$l...$ll passed\n"
