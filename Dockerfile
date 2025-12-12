#################################
###       ALPINE 3.23.0       ###
#################################

FROM alpine:3.23.0

LABEL maintainer="imbrechts.kevin+jdk@protonmail.com"

ENV LASTREFRESH="20251212" \
    JAVA_VERSION="17.0.17" \
    JAVA_HASH="9f9b8b4b827f4e5b958147a81acc0b57" \
    ZULU_VERSION="17.62.17-ca" \
    JAVA_HOME="/opt/java-home" \
    PATH=$PATH:$JAVA_HOME/bin:.

# tar, wget install
RUN apk update && \
    apk add --no-cache --virtual utils \
            tar=1.35-r4 \
            wget=1.25.0-r2

# Download Azul Java, verify the hash, install
WORKDIR /tmp
RUN set -x && \
    wget http://cdn.azul.com/zulu/bin/zulu${ZULU_VERSION}-jdk${JAVA_VERSION}-linux_musl_x64.tar.gz && \
    echo "${JAVA_HASH}  zulu${ZULU_VERSION}-jdk${JAVA_VERSION}-linux_musl_x64.tar.gz" | md5sum -c - && \
    tar -zxvf zulu${ZULU_VERSION}-jdk${JAVA_VERSION}-linux_musl_x64.tar.gz -C /opt && \
    ln -s /opt/zulu${ZULU_VERSION}-jdk${JAVA_VERSION}-linux_musl_x64/ /opt/java-home

# Cleaning
RUN apk del tar wget && \
    rm zulu${ZULU_VERSION}-jdk${JAVA_VERSION}-linux_musl_x64.tar.gz

WORKDIR /

CMD ["/bin/sh"]
