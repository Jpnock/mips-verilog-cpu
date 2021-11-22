FROM ubuntu:20.04

RUN apt update
RUN apt install -y gperf autoconf bison gcc make flex build-essential

RUN mkdir -p /tmp/iverilog-build-dir

WORKDIR /tmp/iverilog-build-dir
RUN git clone https://github.com/steveicarus/iverilog.git


WORKDIR /tmp/iverilog-build-dir/iverilog
# NOTE(@jpnock): This is the version I'm using
RUN git checkout ef01dd1e8161b6ee8bf9549acfa0fefcd1ba8dcb
RUN ./autoconf.sh
RUN ./configure
RUN make
RUN make install
