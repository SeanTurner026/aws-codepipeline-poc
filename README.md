# AWS Code Pipeline

The cloudformation templates in this repository create the following resources:
- vpc (1 public, 3 private subnets)
- s3 bucket x2
- iam role x2
- iam policy x2
- codebuild job
- codepipeline for codebuild job

Once cloudformation runs successfully, any commit will build a docker image and push it to the configured hub.docker repository.

## Requirements
- AWS account -- **NOTE: Running this pipeline will cost money.**
- Hub.docker account -- this pipeline will push built images to a repository `$DOCKER_USERNAME/aws-codepipeline-poc` in the account. An ECR repo would also work but would require code changes.
- S3 bucket for your cloudformation templates (`sean-cfn-templates` in Deploy Commands below).
- Add `secure string` parameter `DockerPassword` to systems manager with the path `/codebuild/docker/password`.
- Replace the default values in the following parameters in `cfn-main.yaml`:
    - `CodeBuildBucketName`
    - `CodePipelineBucketName`
    - `DockerUsername`
    - `GithubBranch`
    - `GithubRepository`
    - `GithubOwner`
- Modify mappings in `cfn-main.yaml` as desired.
- Add github token with full `repo` access in `cloudformation/.env.dev` **NOTE: DO NOT commit your github token to github. This file is gitignored.**
```
$ cat cloudformation/.env.dev
GithubToken=your_token
```

## Deploy Commands
```
aws cloudformation package \
    --template-file cfn-main.yaml \
    --output-template cfn-package.yaml \
    --s3-bucket sean-cfn-templates

aws cloudformation deploy \
    --template-file ~/python/github/aws-codepipeline-nested-cloudformation/cfn-package.yaml \
    --parameter-overrides $(cat cloudformation/.env.dev) \
    --stack-name code-piepline-poc \
    --capabilities CAPABILITY_NAMED_IAM
```
