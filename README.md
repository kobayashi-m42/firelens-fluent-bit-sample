# firelens-fluent-bit-sample

## Terraform

Terraformを利用してAWSにVPC,ECR,ECS(Fargate)を構築します。

`aws-fargate/providers/terraform.tfvars` を追加し、プロファイルを設定してください。

```
profile = "your-profile-name"
```

## ECRへのpush

`direnv`を利用して、AWS CLIのprofileを指定します。

```.envrc
export AWS_PROFILE=your-profile-name
export AWS_REGION=your-region
```

- app用

`app/push-ecr.sh` を実行して、ECRへpushを行います。

`/app`に移動します。

引数に、アカウントIDとタグを指定してください。

```bash
$ ./app/push-ecr.sh 123456789012 1.0.0
```

- fluentbit用

`fluentbit/push-ecr-logrouter.sh` を実行して、ECRへpushを行います。

`/fluentbit`に移動します。

引数に、アカウントIDとタグを指定してください。

```bash
$ ./push-ecr-logrouter.sh 123456789012 1.0.0
```
