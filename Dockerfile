#################################
###       ALPINE 3.13.2       ###
#################################

FROM alpine:3.13.2

LABEL maintainer="imbrechts.kevin+jdk@protonmail.com"

ENV LASTREFRESH="20210222" \
    JAVA_VERSION="14.0.2" \
    JAVA_HASH="3e760b8d66112cd5141c7639c35d65a0" \
    ZULU_VERSION="14.29.23-ca" \
    JAVA_HOME="/opt/java-home" \
    PATH=$PATH:$JAVA_HOME/bin:.

# tar, wget install
RUN apk update && \
    apk add --no-cache --virtual utils \
            tar=1.33-r1 \
            wget=1.21.1-r1

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
