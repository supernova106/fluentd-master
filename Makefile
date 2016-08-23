build:
	docker build -f Dockerfile -t $(DOCKER_REGISTRY)/$(PROJECT_NAME):$(BRANCH_NAME)_$(TIMESTAMP) .
run:
	docker run -d \
	--net=host \
	--restart=always \
        --name=fluentd-master \
        -v $(PWD)/fluent.conf:/fluentd/etc/fluent.conf \
        private-registry.mi.razerapi.com/fluentd-agent:latest
clean:
	docker rm -f fluentd-master

