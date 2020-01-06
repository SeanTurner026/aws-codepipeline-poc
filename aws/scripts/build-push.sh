#!/bin/bash

echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

docker build -t seanturner026/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION $CODEBUILD_SRC_DIR/docker/Dockerfile

docker push seanturner026/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION
