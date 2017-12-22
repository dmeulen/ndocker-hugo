FROM alpine:3.6

MAINTAINER Danny van der Meulen <danny@cb750k6.nl>

ENV \
  ALPINE_MIRROR="nl.alpinelinux.org" \
  ALPINE_VERSION="v3.6" \
  HUGO_VERSION="0.31.1" \
  APK_ADD_TEMP="curl" \
  APK_ADD_PERM=""

EXPOSE 1313

WORKDIR /

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main" > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add ${APK_ADD_TEMP} ${APK_ADD_PERM} && \
  curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -o /tmp/hugo.tar.gz && \
  tar xzf /tmp/hugo.tar.gz -C /usr/bin && \
  apk --purge del ${APK_ADD_TEMP} && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

COPY rootfs/ /

CMD ["/init/run.sh"]
