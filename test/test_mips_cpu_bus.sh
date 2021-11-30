set -euo pipefail

rm -rf ./test/bin/
mkdir -p ./test/bin
./test/run_instruction_testbench.sh
