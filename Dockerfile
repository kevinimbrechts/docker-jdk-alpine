#################################
###       ALPINE 3.18.0       ###
#################################

FROM alpine:3.18.0

LABEL maintainer="imbrechts.kevin+jdk@protonmail.com"

ENV LASTREFRESH="20231030" \
    JAVA_VERSION="17.0.9" \
    JAVA_HASH="8d9910b7433e4643cfcc462b6ce5059d" \
    ZULU_VERSION="17.46.19-ca" \
    JAVA_HOME="/opt/java-home" \
    PATH=$PATH:$JAVA_HOME/bin:.

# tar, wget install
RUN apk update && \
    apk add --no-cache --virtual utils \
            tar=1.34-r3 \
            wget=1.21.4-r0

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
