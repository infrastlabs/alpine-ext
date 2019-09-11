#latest
FROM infrastlabs/alpine-ext
MAINTAINER sam <sldevsir@126.com>

USER root

ADD *.sh /
RUN sh /build.sh

##run as entry
USER entry
WORKDIR /
VOLUME /data
ENTRYPOINT ["/entry.sh"]
CMD ["hello", "world!"]

