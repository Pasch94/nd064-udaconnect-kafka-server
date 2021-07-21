FROM ubuntu:20.04

ENV KAFKA_INSTALL_DIR=/opt/kafka
ENV KAFKA_VERSION=2.8.0
ENV KAFKA_SCALA_VERSION=2.13

# Predefine some values for testing. These will be overwritten by deployment config
ENV KAFKA_LOCATION_TOPIC=location
ENV KAFKA_HOST=localhost
ENV KAFKA_PORT=9092

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    openjdk-8-jdk \
    ant \
    ca-certificates-java \
    netcat \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Create kafka dir
RUN mkdir -p $KAFKA_INSTALL_DIR

WORKDIR $KAFKA_INSTALL_DIR

RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz -O kafka.tgz && tar -xzf kafka.tgz && rm kafka.tgz

WORKDIR $KAFKA_INSTALL_DIR/kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}

EXPOSE $KAFKA_PORT

COPY entrypoint.sh .
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
