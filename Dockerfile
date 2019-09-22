FROM alpine:3.7
LABEL maintainer="York <ivanstang0415@gmail.com>"

RUN mkdir /app \
 && cd /app \
 && wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/20181113.0/udp2raw_binaries.tar.gz \
 && tar xvfz udp2raw_binaries.tar.gz \
 && ls | grep -v -w udp2raw_amd64 | xargs rm \
 && mv udp2raw_amd64 udp2raw

ENV MODE=s
ENV LISTEN_IP=0.0.0.0
ENV LISTEN_PORT=4097
ENV TARGET_IP=127.0.0.1
ENV TARGET_PORT=4096
ENV KEY=""
ENV RAW_MODE=faketcp
ENV OTHER_PARAM=""

ENTRYPOINT [ "/bin/sh", "-c", "/app/udp2raw -${MODE} -l ${LISTEN_IP}:${LISTEN_PORT} -r ${TARGET_IP}:${TARGET_PORT} -k ${KEY} --raw-mode ${RAW_MODE} ${OTHER_PARAM}" ]
