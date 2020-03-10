# Alpine-ext

 **[Alpine-ext](https://hub.docker.com/r/infrastlabs/alpine-ext)** an alpine extend Image based on `alpine-3.8_glibc-2.28` from `frolvlad/alpine-glibc`. With optimization and the essential apks like `tmux` `gosu` `lrzsz` `wget` `tree` `procps` `bash` preinstalled , for **lite** **secure** and **convenience**. (Size at ~30MB)


## Directories

* [src](docs/README.md) (the `Alpine-ext` image.)
* [example](docs/example.md) (sub images base on `Alpine-ext`, with grpasswd, gosu usage.)
* [binary](docs/binary.md)

## QuickStart

- docker hub: `docker run -it --rm -u root infrastlabs/alpine-ext bash`
- aliyun registry: `docker run -it --rm -u root registry.cn-shenzhen.aliyuncs.com/k-pub/alpine-ext:v1.0 bash`

## Features

Alpine-ext with following features:

* apk mirror aliyun/ustc (China)
* TIMEZONE Asia/Shanghai (China)
* binary: tmux, gosu, lrzsz
* apks: curl wget sed grep gawk findutils sudo tree unzip procps htop bash bash-completion vim
* dotfiles: .bashrc .profile .tmux.conf
* gosuctl: gsc add xxx; gsc drop
* init user: root, entry

![tmux-preview](docs/img-apine-ext-tmux.png)

## Contribute

`Alpine-ext` is an open source project under the Apache 2.0 license, and contributions are gladly welcomed!
To submit your changes please open a pull request.
