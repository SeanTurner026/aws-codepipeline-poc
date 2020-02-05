#!/bin/bash

export AWS_ACCOUNT_ID=$CODEBUILD_WEBHOOK_ACTOR_ACCOUNT_ID
export GIT_SHA=$CODEBUILD_RESOLVED_SOURCE_VERSION

$(aws ecr get-login --no-include-email --region $AWS_DEFAULT_REGION)

docker build . \
    -t $REPOSITORY_URI:$GIT_SHA \
    -f $CODEBUILD_SRC_DIR/docker/Dockerfile

docker tag $REPOSITORY_URI:$GIT_SHA \
           $REPOSITORY_URI:latest

docker push $REPOSITORY_URI:$GIT_SHA
docker push $REPOSITORY_URI:latest
