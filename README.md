# POC for Terraform + Render + AWS

This POC is intended to deploy resources to AWS and Render using Terraform

## S3 Backend configuration 

Terraform works better with a remote backend and S3 is a common option. https://developer.hashicorp.com/terraform/language/settings/backends/s3

The Cloudformation template file [terraform-s3-backend-cf-template.yaml](./terraform-s3-backend-cf-template.yaml) has all the resources needed to deploy a basic functional S3 backend.

Default region => Ireland (choose as you wish)

```shell
export AWS_DEFAULT_REGION=eu-west-1
```

The template can be deployed with the following command
```shell

STACK_ID=$( \
  aws cloudformation create-stack --stack-name poc-render --template-body file://terraform-s3-backend-cf-template.yaml --capabilities CAPABILITY_NAMED_IAM \
  --query 'StackId' --output text \
)

TF_USERNAME=$( \
  aws cloudformation describe-stacks --stack-name $STACK_ID \
  --query 'Stacks[0].Outputs[?OutputKey==`TerraformUserOutput`].OutputValue | [0]' --output text \
)
  
TF_CREDENTIALS=$( \
  aws iam create-access-key --user-name $TF_USERNAME \
  --query 'AccessKey'
)
```

Don't forget to store your credentials

```shell
echo $TF_CREDENTIALS
```


# Usage

## Required variables

```shell
export AWS_DEFAULT_REGION=eu-west-1
export AWS_ACCESS_KEY_ID=*****
export AWS_SECRET_ACCESS_KEY=*****
export RENDER_API_KEY=*****
export RENDER_EMAIL=*****
```

## Terraform

```shell
terraform init
terraform plan
terraform apply
```
