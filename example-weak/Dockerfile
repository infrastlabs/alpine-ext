#latest
ARG repo=docker.io
FROM ${repo}/infrastlabs/alpine-ext
MAINTAINER sam <sldevsir@126.com>

USER root

ADD *.sh /
RUN sh /build.sh

##run as root
USER root
WORKDIR /root

ENTRYPOINT ["/entry.sh"]
# CMD /entry.sh #CMD ["bash", "-c", "tail -f /dev/null"]
