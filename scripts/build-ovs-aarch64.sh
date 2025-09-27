#!/usr/bin/env bash

set -x

source /etc/os-release

DOCKER_REGISTRY=${DOCKER_REGISTRY:-osism.harbor.regio.digital}
DOCKER_NAMESPACE=${DOCKER_NAMESPACE:-packages}

# https://docs.openvswitch.org/en/latest/intro/install/debian/#building-open-vswitch-debian-packages

git clone https://github.com/openvswitch/ovs.git

pushd ovs
git checkout $OVS_VERSION
./boot.sh
./configure \
    --target=aarch64-buildroot-linux-gnu \
    --host=aarch64-buildroot-linux-gnu \
    --build=x86_64-pc-linux-gnu
make debian
dpkg-checkbuilddeps
make debian-deb DEB_HOST_ARCH=arm64
cat _debian/config.log
popd

find . -type f -name "*openvswitch*.deb" -exec cp {} files/ovs/files \;
ls -la files/ovs/files

pushd files/ovs
docker build -t $DOCKER_REGISTRY/$DOCKER_NAMESPACE/ovs-$ID-$VERSION_CODENAME:$OVS_VERSION-aarch64 .
popd
