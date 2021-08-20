### BUILD image
FROM alpine:3.14.1

# Update packages
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available && \
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

WORKDIR /scripts
COPY ./scripts /scripts
