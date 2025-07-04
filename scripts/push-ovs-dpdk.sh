#!/usr/bin/env bash

set -x

source /etc/os-release

DOCKER_REGISTRY=${DOCKER_REGISTRY:-osism.harbor.regio.digital}
DOCKER_NAMESPACE=${DOCKER_NAMESPACE:-packages}

docker push $DOCKER_REGISTRY/$DOCKER_NAMESPACE/ovs-dpdk-$ID-$VERSION_CODENAME:$OVS_VERSION
