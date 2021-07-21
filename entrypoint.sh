#!/bin/bash

# Start zookeepter server in background
./bin/zookeeper-server-start.sh config/zookeeper.properties &

# Start kafka broker service 
./bin/kafka-server-start.sh config/server.properties &

# Wait a little until everything has started
# This may be implemented more reliable
sleep 5

# Create kafka topics
./bin/kafka-topics.sh --create --topic $KAFKA_LOCATION_TOPIC --bootstrap-server $KAFKA_HOST:$KAFKA_PORT

while [[ $(ps -aux | grep [k]afka) ]]; 
do
	sleep 5
done
