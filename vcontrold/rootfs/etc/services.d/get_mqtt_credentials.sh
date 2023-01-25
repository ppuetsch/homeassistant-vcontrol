#!/bin/bash

export MQTT_HOST=$(bashio::config 'mqtt_host')
export MQTT_PORT=$(bashio::config 'mqtt_port')
export MQTT_USER=$(bashio::config 'mqtt_user')
export MQTT_PASSWORD=$(bashio::config 'mqtt_password')
export MQTT_TOPIC=$(bashio::config 'mqtt_topic')

if [ -z "$MQTT_HOST"] && [ -z "$MQTT_PORT"] && [ -z "$MQTT_USER"] && [ -z "$MQTT_PASSWORD"]
    bashio::log.error "Using configured MQTT Host $MQTT_HOST"
elif ! bashio::services.available "mqtt"; then
    bashio::log.error "No MQTT broker configured and no internal MQTT service found"
    exit
else
    export MQTT_HOST=$(bashio::services mqtt "host")
    export MQTT_PORT=$(bashio::services mqtt "port")
    export MQTT_USER=$(bashio::services mqtt "username")
    export MQTT_PASSWORD=$(bashio::services mqtt "password")
    bashio::log.error "Using internal MQTT Host $MQTT_HOST"
fi
