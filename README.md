# AWS Code Pipeline Cloudformation

The cloudformation templates in this repository will create a code pipeline which uses cloudformation to deploy base resources that can be consumed by applications.

The following resources are created:
- vpc (1 public, 3 private subnets)
- s3 bucket x2
- ecr repository
- iam role x2
- iam policy x2
- codebuild job
- codepipeline x2

Once the cloudformation codepipeline exits successfully, any commit will trigger the application codepipeline to build a docker image and push it to the configured ecr repository.

## Requirements

- AWS account -- **NOTE: Running this pipeline will cost money.**
- Replace the default values in the following parameters in `cfn-main.yaml`:
    - `CodeBuildBucketName`
    - `CodePipelineBucketName`
    - `GithubBranch`
    - `GithubRepository`
    - `GithubOwner`
- Modify mappings in `cloudformation/initiator_resources.yaml` as desired.
- Add github token with full `repo` access in `cloudformation/.env.dev` **NOTE: DO NOT commit your github token to github. This file is gitignored.**
```
$ cat cloudformation/.env.dev
GithubToken=your_token
```

## Deploy Command
```
aws cloudformation deploy --template-file cloudformation/codepipeline_initiator.yaml --stack-name sean-codepipeline-initiator --parameter-overrides $(cat cloudformation/.env.dev) --capabilities CAPABILITY_NAMED_IAM
```

## Nested Stacks

This project was previously done using nested stacks. Please see the `nested-stacks` git branch to create the same resources without using codepipeline to deploy cloudformation.
