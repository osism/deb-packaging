#!/usr/bin/env bash

set -x

DOCKER_REGISTRY=${DOCKER_REGISTRY:-osism.harbor.regio.digital}
DOCKER_NAMESPACE=${DOCKER_NAMESPACE:-packages}

docker push $DOCKER_REGISTRY/$DOCKER_NAMESPACE/ovs:$VERSION
