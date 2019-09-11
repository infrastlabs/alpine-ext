#!/usr/bin/env sh

#domain="mirrors.ustc.edu.cn"
domain="mirrors.aliyun.com"
echo "http://$domain/alpine/v3.8/main" > /etc/apk/repositories
echo "http://$domain/alpine/v3.8/community" >> /etc/apk/repositories

apk add --no-cache ca-certificates wget git 
#apk add lrzsz ##testing repo

mkdir /ws && cd /ws
    ##wget
    #gosu
    wget https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 -O gosu
    chmod +x gosu
    #lrzsz
    #git clone https://github.com/jnavila/lrzsz  #build err
    ver=lrzsz-0.12.20 && wget https://ohse.de/uwe/releases/$ver.tar.gz
    tar -zxf $ver.tar.gz && rm -f $ver.tar.gz && mv $ver lrzsz
    #tmux
    ver=tmux-2.3 && wget https://github.com/tmux/tmux/releases/download/2.3/$ver.tar.gz
    tar -zxf $ver.tar.gz && rm -f $ver.tar.gz && mv $ver tmux-src 
    ls -lh

    ##build
    apk add --no-cache build-base
    #lrzsz
    cd lrzsz && ./configure && make
    cd .. && cp lrzsz/src/l*z . && rm -rf lrzsz && mv lrz rz && mv lsz sz

    #tmux
    apk add libevent-dev ncurses-dev
    cd tmux-src && ./configure && make
    cd .. && cp tmux-src/tmux . && rm -rf tmux-src

    apk del build-base
    ls -lh
cd ..

rm -f /build.sh