#################################
###       ALPINE 3.10.3       ###
#################################

FROM alpine:3.10.3

LABEL maintainer="imbrechts.kevin+jdk@protonmail.com"

ENV LASTREFRESH="20191115" \
    JAVA_VERSION="8.0.222" \
    JAVA_HASH="9e05228f783e32cf248d3d870243dc8f" \
    ZULU_VERSION="8.40.0.25-ca" \
    JAVA_HOME="/opt/java-home" \
    PATH=$PATH:$JAVA_HOME/bin:.

# Git, tar, wget install
RUN apk update && \
    apk add --no-cache --virtual utils \
            tar=1.32-r0 \
            wget=1.20.3-r0

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
