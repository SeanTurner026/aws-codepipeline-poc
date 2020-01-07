#!/bin/bash

echo $DOCKER_PASSWORD | docker login --username $DOCKER_USERNAME --password-stdin

docker build . \
    -t $DOCKER_USERNAME/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION \
    -f $CODEBUILD_SRC_DIR/docker/Dockerfile

docker tag $DOCKER_USERNAME/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION \
           $DOCKER_USERNAME/aws-codepipeline-poc:latest

docker push $DOCKER_USERNAME/aws-codepipeline-poc:$CODEBUILD_RESOLVED_SOURCE_VERSION
docker push $DOCKER_USERNAME/aws-codepipeline-poc:latest
