#!/usr/bin/env bash
set -xe

VERSION=v3.3.1

# https://docs.openvswitch.org/en/latest/intro/install/debian/#building-open-vswitch-debian-packages

sudo apt-get update
sudo apt-get install -y \
    autoconf \
    automake \
    build-essential \
    bzip2 \
    debhelper-compat \
    dh-exec \
    dh-python \
    dh-sequence-python3 \
    dh-sequence-sphinxdoc \
    fakeroot \
    gcc-aarch64-linux-gnu \
    graphviz \
    iproute2 \
    libcap-ng-dev \
    libdbus-1-dev \
    libnuma-dev \
    libpcap-dev \
    libssl-dev \
    libtool \
    libunbound-dev \
    openssl \
    pkg-config \
    procps \
    python3-all-dev \
    python3-setuptools \
    python3-sortedcontainers \
    python3-sphinx
git clone https://github.com/openvswitch/ovs.git

pushd ovs
git checkout $VERSION
./boot.sh
./configure \
    --target=aarch64-buildroot-linux-gnu \
    --host=aarch64-buildroot-linux-gnu \
    --build=x86_64-pc-linux-gnu
make debian
dpkg-checkbuilddeps
make debian-deb DEB_HOST_ARCH=arm64
cat config.log
popd
