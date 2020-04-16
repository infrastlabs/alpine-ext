#!/bin/bash
#setenforce 0

#registry
# repo=docker.io
repo=registry.cn-shenzhen.aliyuncs.com
source /etc/profile #~/.auth-docker-registry #set DOCKER_REGISTRY_PW DOCKER_REGISTRY_USER
#export |grep DOCKER_REG
echo "${DOCKER_REGISTRY_PW_sdsir}" |docker login --username=${DOCKER_REGISTRY_USER_sdsir} --password-stdin $repo

ns=infrastlabs
cur=$(cd "$(dirname "$0")"; pwd) 

#bin
ver=bin
parent=$repo/$ns/alpine-ext:$ver
#docker build --pull -t $repo/$ns/alpine-ext:$ver $cur/binary/.
#docker push $repo/$ns/alpine-ext:$ver

#src
ver=latest #v1.0
# docker build --pull -t $repo/$ns/alpine-ext:$ver --build-arg repo=$repo $cur/src/. 
# docker push $repo/$ns/alpine-ext:$ver

#example-gosu/weak
# docker build --pull -t $repo/$ns/alpine-ext:gosu --build-arg repo=$repo $cur/example-gosu/.
# docker push $repo/$ns/alpine-ext:gosu
docker build --pull -t $repo/$ns/alpine-ext:weak --build-arg repo=$repo $cur/example-weak/.
docker push $repo/$ns/alpine-ext:weak
