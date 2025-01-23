#!/usr/bin/env bash

# https://docs.openvswitch.org/en/latest/intro/install/debian/#building-open-vswitch-debian-packages

git clone https://github.com/openvswitch/ovs.git

pushd ovs
git checkout $VERSION
./boot.sh
./configure
make debian
dpkg-checkbuilddeps
make debian-deb
popd
