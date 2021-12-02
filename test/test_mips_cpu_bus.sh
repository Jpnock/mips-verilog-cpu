# TODO: Remove TEST_WAIT before submission.
set -euo pipefail

SOURCE_DIR=${1:-rtl}
TEST_INSTR=${2-}
TEST_WAIT=${3:-0}

rm -rf ./test/bin/
mkdir -p ./test/bin
./test/run_instruction_testbench.sh $SOURCE_DIR $TEST_INSTR $TEST_WAIT
