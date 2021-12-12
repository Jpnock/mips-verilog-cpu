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
