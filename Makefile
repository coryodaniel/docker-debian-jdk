.PHONY: build run release url clean shell

REGISTRY 	 	:= quay.io
IMAGE_NAME 	:= coryodaniel/debian-jdk
IMAGE_URL  	:= ${REGISTRY}/${IMAGE_NAME}
TEST_PREFIX := deb-jdk-dbg

all: clean build run

url:
	@echo ${IMAGE_URL}

build:
	docker build -t ${IMAGE_NAME} .

release: REL_TIME=$(shell date +%s)
release:
	docker tag ${IMAGE_NAME} ${IMAGE_URL}:latest && \
	docker tag ${IMAGE_NAME} ${IMAGE_URL}:${REL_TIME} && \
	docker push ${IMAGE_URL}:latest && \
	docker push ${IMAGE_URL}:${REL_TIME}

shell:
	docker run --name ${TEST_PREFIX}-shell -it ${IMAGE_NAME}:latest /bin/bash

tmp:
	mkdir -p ./tmp

clean:
	rm -rf ./tmp
	docker ps --format "{{.Names}}" -a | grep "${TEST_PREFIX}" | xargs docker rm

run:
	docker run --name ${TEST_PREFIX} --rm ${IMAGE_NAME}:latest
