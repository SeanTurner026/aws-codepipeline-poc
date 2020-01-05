#!/bin/bash

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

docker build -t seanturner026/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION ~/docker/Dockerfile

docker push seanturner026/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION
