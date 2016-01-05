FROM alpine:3.3
MAINTAINER Pete Colapietro <pcssi@users.noreply.github.com>

ENV GLIBC_APK_VERSION glibc-2.21-r2.apk
ENV GLIBC_BIN_APK_VERSION glibc-bin-2.21-r2.apk

# Download and install glibc
RUN apk add --update curl && \
  curl -o ${GLIBC_APK_VERSION} "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/${GLIBC_APK_VERSION}" && \
  apk add --allow-untrusted ${GLIBC_APK_VERSION} && \
  curl -o ${GLIBC_BIN_APK_VERSION} "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/${GLIBC_BIN_APK_VERSION}" && \
  apk add --allow-untrusted ${GLIBC_BIN_APK_VERSION} && \
  /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
  echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
  apk del curl && \
  rm -f ${GLIBC_APK_VERSION} ${GLIBC_BIN_APK_VERSION} && \
  rm -rf /var/cache/apk/*
