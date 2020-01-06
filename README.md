# AWS Code Pipeline

The cloudformation templates in this repository create the following resources:
- vpc
- s3 bucket x2
- codebuild job
- codepipeline for codebuild job

Once cloudformation runs successfully, any commit

### Requirements
- S3 bucket for your cloudformation templates (`sean-cfn-templates` in Deploy Commands)
- Replace hard coded bucket name parameters in `aws/resources/s3.yaml`
- Replace `GithubRepository` and `GithubOwner` parameters in `aws/cfn-main.yaml` and `aws/resources/codepipeline.yaml`
- Replace `DockerUsername` parameter from `aws/cfn-main.yaml` and `aws/resources/codebuild.yaml`
- Modify `docker build` and `docker push` commands in `aws/scripts/build-push.sh` to your own hub.docker account (or alternatively setup an ecr repo)
- Add ssm parameter `DockerPassword` to systems manager with the path `/codebuild/docker/password`
- Add github token with full `repo` access in `aws/resources/.env.dev`
```
$ cat aws/resources/.env.dev
GithubToken=your_token
```

### Deploy Commands
```
aws cloudformation package \
    --template-file aws/cfn-main.yaml \
    --output-template aws/cfn-package.yaml \
    --s3-bucket sean-cfn-templates

aws cloudformation deploy \
    --template-file ~/python/github/aws-codepipeline-poc/aws/cfn-package.yaml \
    --parameter-overrides $(cat aws/resources/.env.dev) \
    --stack-name code-piepline-poc \
    --capabilities CAPABILITY_NAMED_IAM
```
