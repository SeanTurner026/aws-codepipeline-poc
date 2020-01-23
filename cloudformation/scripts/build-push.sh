#!/bin/bash

export GIT_SHA=$CODEBUILD_RESOLVED_SOURCE_VERSION
export AWS_ACCOUNT_ID=$CODEBUILD_WEBHOOK_ACTOR_ACCOUNT_ID

docker build . \
    -t $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/aws-codepipeline-poc:$GIT_SHA \
    -f $CODEBUILD_SRC_DIR/docker/Dockerfile

docker tag $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/aws-codepipeline-poc:$GIT_SHA \
           $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/aws-codepipeline-poc:latest

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/aws-codepipeline-poc:$GIT_SHA
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/aws-codepipeline-poc:latest
