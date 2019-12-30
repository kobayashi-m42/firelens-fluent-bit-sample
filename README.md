# firelens-fluent-bit-sample

AWS Fargate上のFirelensを利用して、ログをCloudWatchLogsとKinesisFirehoseに送信するサンプルです。

Fluent Bitに利用しログの種別によって送信先を分けています。

## サンプルの実行方法

1.Terraformを利用してAWSに必要なリソースを構築します。

2.Application(今回はログを10秒間出力するだけ)とLogrouterのイメージをECRにpushします。

3.ECSのコンソールから、タスクを手動で実行します。

4.ログがCloudWatchLogsとKinesisFirehoseに出力されていることを確認します。

## Terraform

Terraformを利用して必要なリソースを構築します。

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

引数に、アカウントIDとECRのリポジトリ名を指定してください。

```bash
$ ./app/push-ecr.sh 123456789012 firelens-fluentbit-sample-app
```

- fluentbit用

`fluentbit/push-ecr-logrouter.sh` を実行して、ECRへpushを行います。

`/fluentbit`に移動します。

引数に、アカウントIDとECRのリポジトリ名を指定してください。

```bash
$ ./push-ecr-logrouter.sh 123456789012 firelens-fluentbit-sample-logrouter
```
