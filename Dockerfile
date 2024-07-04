### BUILD image
FROM alpine:3.20.1

# Update packages
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available && \
    sync

ONBUILD RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available --ignore openjdk11 openjdk11-jmods openjdk11-demos openjdk11-doc java-common java-cacerts openjdk11-jre-headless openjdk11-jre openjdk11-jdk && \
    sync

# Install OpenJDK 11.0.12
RUN apk --no-cache add openjdk11 --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENTRYPOINT ["/bin/ash", "-c"]

RUN mkdir -p /scripts

RUN addgroup -g 1000 -S ileap && \
    adduser -u 1000 -G ileap -h /build -s /sbin/nologin -S ileap && \
    chmod 755 /build
