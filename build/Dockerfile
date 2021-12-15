FROM ubuntu:20.04

RUN apt update
RUN apt install -y git gperf autoconf bison gcc make flex build-essential gcc-mips-linux-gnu

RUN mkdir -p /tmp/iverilog-build-dir

WORKDIR /tmp/iverilog-build-dir
RUN git clone https://github.com/steveicarus/iverilog.git


WORKDIR /tmp/iverilog-build-dir/iverilog
# NOTE(@jpnock): This is the version I'm using
RUN git checkout v11_0
RUN chmod +x ./autoconf.sh
RUN ./autoconf.sh
RUN chmod +x ./configure
RUN ./configure
RUN make
RUN make install
