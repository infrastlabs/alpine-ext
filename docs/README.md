# Alpine-ext detail

## Shell-bins

* `gsc` : gosuctl (`gsc add entry`, `gsc drop`)
* `epasswd`: expect passwd (must exec with root)
* `erpasswd`: expect random passwd (recommended random pw for docker, save when build, for safety )

## Environment variables

The environment variables can be used to configure SSH server

| Variable |    Default    | Description |
| -------- | ------------- | ----------- |
| TIMEZONE | Asia/Shanghai | China       |
| LANG     | C.UTF-8       |             |
| VER      | v1.0          |             |

## lrzsz usage

When in windows or ZModem supported, you can use `rz`/`sz` for quick file transmission

```text
  upload: rz file
download: sz file
```

## tmux usage

Tmux 2.3, compatible with vim 8.1

```bash
entry:
tmux #new
tmux att -dt 0 #exist
```

```text
control:
  super: ctrl+a
split v: super + \
split h: super + -
   move: super + up/down/left/right 
```

## gosu usage

> Avoid to use su with a external pid and interactive promotion for password.  

First give suid to normal user when img built, Then when your container first startup you can do something with root for the initial. (remember to drop suid with gosu)

- exec when img build

```bash
gsc add xxx
```

- scripts to run

```bash
file=/tmp/gosu-root.sh
cat > $file <<EOF
ls -la /root
chown -R www:www /srv #test
erpasswd root
gsc drop #drop suid of gosu, for safety
EOF
chmod +x $file

printf "gosu exec as root:(exec when container first startup)"
gosu root bash -c $file && rm -f $file
```

## Security

- user with entry (none root)

- image check: [dive](https://github.com/wagoodman/dive) [clair](https://github.com/coreos/clair) (TODO)

- CAIID

```bash
docker inspect frolvlad/alpine-glibc:alpine-3.8_glibc-2.28 -f "{{.RepoDigests}}"
[frolvlad/alpine-glibc@sha256:51d816dfedfaf89e52319add7cf5849dbf7295ec8980ca4a58ac963aa1485a10]
```

- suid sgid

`for i in $(find / -type f \( -perm +6000 -o -perm +2000 \)); do chmod ug-s $i; done`

```bash
/usr/bin/passwd
/usr/bin/chage
/usr/bin/sudo
/usr/bin/chfn
/usr/bin/newgrp
/usr/bin/chsh
/usr/bin/expiry
/usr/bin/gpasswd
/bin/busybox
/bin/su
/sbin/unix_chkpwd
```

## Build to docker.io/aliyun

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
ns=infrastlabs
cur=$(cd "$(dirname "$0")"; pwd)

#bin
ver=bin
parent=$repo/$ns/alpine-ext:$ver
docker build --pull -t $parent $cur/bin/.

#src
ver=v1.0 #latest
docker build --pull -t $repo/$ns/alpine-ext:$ver --build-arg parent=$parent  $cur/src/. 
docker push $repo/$ns/alpine-ext:$ver
```
