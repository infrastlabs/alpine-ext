# Alpine-ext

## Intro

> Basic top alpine docker images with tmux/lrzsz/gosu/... and other init sys soft and dotfiles aim at lite and better image use. 

 **[Alpine-ext](https://hub.docker.com/r/infrastlabs/alpine-ext)** Image based on `alpine-3.8_glibc-2.28` from `frolvlad/alpine-glibc`. (Size at ~30MB)

### Tags

* bin (downloading and compileing binaries for alpine-ext.)
* latest (alpine-ext images.)
* example (sub example with grpasswd, gosu usage.)

### Features

Alpine-ext with following features:

* apk mirror aliyun/ustc
* TIMEZONE Asia/Shanghai
* bin: gosu, lrzsz, tmux
* apk: curl wget sed grep gawk sudo tree unzip procps htop bash bash-completion vim
* dotfiles: .bashrc .profile .tmux.conf
* gosuctl: gsc add xxx; gsc drop
* user: root; entry

### Shell-Bins

* gsc gosuctl: gsc add entry, gsc drop
* epasswd: expect passwd (must exec with root)
* erpasswd: expect random passwd (recommended random pw for docker, save when build, for safety )

### Environment variables

The environment variables can be used to configure SSH server

| Variable      | Default | Description |
| ------------- | -------------- |---------|
| TIMEZONE      | Asia/Shanghai  |  China  |
| LANG          | C.UTF-8        |         |
| VER           | v1.0           |         |

## Use

- docker run

`docker run -it --rm -u root infrastlabs/alpine-ext bash`  (run with container's user `root`)

![](images/apine-ext-tmux.png)

`docker run -it --rm infrastlabs/alpine-ext:example` (exec in bash: `su` with root's pw `root`)

```bash
#!/usr/bin/env bash
echo $@

#scripts to run
file=/tmp/gosu-root.sh
cat > $file <<EOF
ls -la /root
chown -R www:www /srv #test
erpasswd root
epasswd root root  #rechange root's pw to: root (example with weak password)
gsc drop #add this
EOF
chmod +x $file

printf "\ngosu exec as root:\n"
gosu root bash -c $file && rm -f $file

printf "\nvalidate dropd permission:\n"
gosu root ls -la /root
gsc add entry

exec /bin/bash
```

![](images/example-grpasswd-gosu.png)

- gosu

```bash
sudo su 
gosuctl add
exit
gosu root ls -la ~
```

```bash
sudo su
gosuctl drop
exit
gosu root ls -la ~
```

- tmux

```bash
entry:
tmux #new
tmux att -dt 0 #exist
```

```
control:
  super: ctrl+a
split v: super + \
split h: super + -
   move: super + up/down/left/right 
```

## Build Aliyun



- registry login

```bash
#registry
repo=docker.io #registry.cn-shenzhen.aliyuncs.com
source ~/.auth-docker-registry #set DOCKER_REGISTRY_PW DOCKER_REGISTRY_USER
#export |grep DOCKER_REG
echo "${DOCKER_REGISTRY_PW}" |docker login --username=${DOCKER_REGISTRY_USER} --password-stdin $repo
```

- build push

```bash
ns=infrastlabs #k-pub
ver=v1.0 #latest
cur=$(cd "$(dirname "$0")"; pwd) 

#bin
parent=$repo/$ns/alpine-ext-bin:$ver
#docker build --pull -t $parent $cur/bin/.
#src
docker build --pull -t $repo/$ns/alpine-ext:$ver --build-arg parent=$parent  $cur/src/. 
docker push $repo/$ns/alpine-ext:$ver
```


## Contribute

Alpine-ext is an open source project under the Apache 2.0 license, and contributions are gladly welcomed!
To submit your changes please open a pull request.
