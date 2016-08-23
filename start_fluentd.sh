#!/bin/bash

CONTAINER_NAME=fluentd_new

docker rm -f $CONTAINER_NAME
docker run --name $CONTAINER_NAME \
    -d \
    --net=host \
    --restart=always \
    -e FLUENTD_CONF=fluent.conf \
    -e ELASTICSEARCH_ENDPOINT='https://search-mies-d5jaoeka4go4ufc5sg2t3ksove.us-east-1.es.amazonaws.com' \
    -e AWS_ACCESS_KEY='AKIAJJ26545XZVVRK4QA' \
    -e AWS_SECRET_KEY='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' \
    -e AWS_REGION='us-east-1' \
    private-registry.mi.razerapi.com/fluentd-aws-es:master_1470014135
