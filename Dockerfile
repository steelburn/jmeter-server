#inspired by justb4/docker-jmeter, hhcordero/docker-jmeter-server

FROM alpine:3

ARG JMETER_VERSION="5.4.2"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD_URL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ARG TZ="Asia/Kuala_Lumpur"
ENV TZ ${TZ}
ENV IP 0.0.0.0
ENV RMI_PORT 1099

# Install extra packages
RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add --update openjdk8-jre tzdata curl wget unzip bash nss \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /tmp/dependencies \ 
    && curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
    && mkdir -p /opt \
    && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm -rf /tmp/dependencies \
    && mkdir -p /plugins

COPY plugins /plugins

# Set global PATH for jmeter
ENV PATH $PATH:${JMETER_BIN}

COPY entrypoint.sh /

WORKDIR ${JMETER_HOME}
EXPOSE ${RMI_PORT}

ENTRYPOINT ["/entrypoint.sh"]