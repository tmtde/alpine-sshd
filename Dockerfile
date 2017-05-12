FROM alpine:3.5
MAINTAINER Timo Lindenblatt <timo.lindenblatt@tmt.de>
RUN apk add --update openssh && \
rm -rf /var/cache/apk/*
COPY docker-entrypoint.sh /usr/local/bin/
EXPOSE 22
ENTRYPOINT docker-entrypoint.sh
