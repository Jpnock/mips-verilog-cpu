# Verilog CPU

An implementation of a MIPS I ISA compatible CPU.

See the [docs](./docs/) folder for the CPU [datasheet](./docs/datasheet.pdf).

## Dependencies

The following packages are required

- gcc-mips-linux-gnu
- make
- iverilog (tested against commit-hash ef01dd1e8161b6ee8bf9549acfa0fefcd1ba8dcb)

## Building and testing

To build the CPU, build the tests and run them:

```bash
$ make
```

To build the CPU:

```bash
$ make build
```

To build the tests, without running them:

```bash
$ make build-tests
```

To run the tests:

```bash
$ make test
```

## Directory structure

- `.github` contains Github Actions CI workflows for automated testing of the project
- `build` contains files relevant to building the project, such as a Dockerfile that is used by the CI pipeline
- `docs` contains CPU documentation, including the datasheet
- `rtl` contains the HDL for the CPU
- `rtl/test` contains Verilog module-level CPU test-benches
- `scripts` contains various scripts created during development for the purpose of automating manual processes
- `test/mips` contains instruction-level tests, such as C and ASM tests. The binaries are checked into Git to ensure reproducability. They can be re-assembled with `./test/build_instruction_testbench.sh` and `./test/build_c_testbench.sh`
- `test/rtl` contains the HDL harness for instruction-level testing
