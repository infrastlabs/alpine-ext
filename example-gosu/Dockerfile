#latest
ARG repo=docker.io
FROM ${repo}/infrastlabs/alpine-ext
MAINTAINER sam <sldevsir@126.com>

USER root

ADD *.sh /
RUN sh /build.sh

##run as www
USER www
WORKDIR /
VOLUME /data
ENTRYPOINT ["/entry.sh"]
CMD ["hello", "world!"]

