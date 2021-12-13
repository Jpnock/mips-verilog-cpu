#!/bin/bash

set -euo pipefail

SOURCE_DIR=${1:-rtl}
TEST_INSTR=${2-}

rm -rf ./test/bin/
mkdir -p ./test/bin
./test/run_instruction_testbench.sh $SOURCE_DIR $TEST_INSTR
