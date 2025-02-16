#!/usr/bin/env bash

VERSION=v3.3.1

# https://docs.openvswitch.org/en/latest/intro/install/debian/#building-open-vswitch-debian-packages

git clone https://github.com/openvswitch/ovs.git

pushd ovs
git checkout $VERSION
./boot.sh
./configure --with-dpdk=shared
make debian
dpkg-checkbuilddeps
make debian-deb
popd
