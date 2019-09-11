ARG parent=infrastlabs/alpine-ext:bin
FROM ${parent} as src

FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28
MAINTAINER sam <sldevsir@126.com>

ENV TIMEZONE Asia/Shanghai
ENV LANG C.UTF-8
ENV VER=v1.0
#EXPOSE 22

#res #/usr/bin: gosu tmux lrzsz
COPY --from=src /ws/ /usr/bin/
ADD res/dot/. /root/

ADD *.sh /
RUN sh /build.sh

##run as entry
USER entry
WORKDIR /
