#!/usr/bin/env bash

set -x

DOCKER_REGISTRY=${DOCKER_REGISTRY:-osism.harbor.regio.digital}
DOCKER_NAMESPACE=${DOCKER_NAMESPACE:-packages}

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

find . -type f -name "*openvswitch*.deb" -exec cp {} files/ovs/files \;
ls -la files/ovs/files

pushd files/ovs
docker build -t $DOCKER_REGISTRY/$DOCKER_NAMESPACE/ovs:$VERSION .
popd
