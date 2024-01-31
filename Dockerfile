FROM apache/apisix:3.8.0-debian

ENV VERSION 0.5.0
ENV CORAZA_FILENAME coraza-proxy-wasm-${VERSION}.zip

ADD https://github.com/corazawaf/coraza-proxy-wasm/releases/download/$VERSION/$CORAZA_FILENAME .

USER root

RUN <<EOF

  apt-get install zip -y
  unzip $CORAZA_FILENAME -d /usr/local/apisix/proxywasm
  rm $CORAZA_FILENAME
  apt-get remove zip -y
  chown -R apisix:apisix /usr/local/apisix/proxywasm

EOF

USER apisix
