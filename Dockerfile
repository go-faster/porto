FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    g++ \
    cmake \
    protobuf-compiler \
    libprotobuf-dev \
    libgoogle-perftools-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    libnl-route-3-dev \
    libnl-idiag-3-dev \
    libncurses5-dev \
    libelf-dev \
    zlib1g-dev \
    pandoc \
    libbpf-dev \
    libtool \
    autoconf

WORKDIR /porto
COPY . ./

WORKDIR /porto/build

RUN cmake ..
RUN make -j$(nproc)

RUN mkdir bin
RUN cp portod portoctl bin
RUN tar czvf porto.tgz -C bin .