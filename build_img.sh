#!/bin/bash
#setenforce 0

#registry
repo=registry.cn-shenzhen.aliyuncs.com
source ~/.auth-docker-registry #set DOCKER_REGISTRY_PW DOCKER_REGISTRY_USER
#export |grep DOCKER_REG
echo "${DOCKER_REGISTRY_PW_sldevdir}" |docker login --username=${DOCKER_REGISTRY_USER_sldevdir} --password-stdin $repo

ns=infrastlabs
ver=latest #v1.0
cur=$(cd "$(dirname "$0")"; pwd) 

#bin
parent=$repo/$ns/alpine-ext:bin
#docker build --pull -t $parent $cur/bin/.

#src
# docker build --pull -t $repo/$ns/alpine-ext:$ver --build-arg parent=$parent $cur/src/. 
# docker push $repo/$ns/alpine-ext:$ver

#example
docker build -t $repo/$ns/alpine-ext:gosu $cur/example-gosu/.
docker push $repo/$ns/alpine-ext:gosu
docker build -t $repo/$ns/alpine-ext:weak $cur/example-weak/.
docker push $repo/$ns/alpine-ext:weak
