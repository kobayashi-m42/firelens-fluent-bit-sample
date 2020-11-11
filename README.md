# firelens-fluent-bit-sample

AWS Fargate上のFirelensを利用して、ログをCloudWatchLogsとKinesisFirehoseに送信するサンプルです。

Fluent Bitを利用しログの種別によって送信先を分けています。

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

引数に、アカウントIDとECRのリポジトリ名を指定してください。

```bash
$ ./app/push-ecr.sh 123456789012 firelens-fluentbit-sample-app
```

- fluentbit用

`fluentbit/push-ecr-logrouter.sh` を実行して、ECRへpushを行います。


引数に、アカウントIDとECRのリポジトリ名を指定してください。

```bash
$ ./fluentbit/push-ecr-logrouter.sh 123456789012 firelens-fluentbit-sample-logrouter
```

## ログサンプル
Golangのアプリケーションのログは下記の通りです。

serviceが`access`の場合はKinesisFirehoseへ、serviceが`error`の場合はCloudWatchLogsへ送信します。


```bash
{"countdown":10,"level":"info","msg":"FireLens Fluent Bit Test","service":"error","time":"2020-01-24T21:25:05+09:00"}
{"countdown":9,"level":"info","msg":"FireLens Fluent Bit Test","service":"access","time":"2020-01-24T21:25:06+09:00"}
{"countdown":8,"level":"info","msg":"FireLens Fluent Bit Test","service":"error","time":"2020-01-24T21:25:07+09:00"}
{"countdown":7,"level":"info","msg":"FireLens Fluent Bit Test","service":"access","time":"2020-01-24T21:25:08+09:00"}
{"countdown":6,"level":"info","msg":"FireLens Fluent Bit Test","service":"error","time":"2020-01-24T21:25:09+09:00"}
{"countdown":5,"level":"info","msg":"FireLens Fluent Bit Test","service":"access","time":"2020-01-24T21:25:10+09:00"}
{"countdown":4,"level":"info","msg":"FireLens Fluent Bit Test","service":"error","time":"2020-01-24T21:25:11+09:00"}
{"countdown":3,"level":"info","msg":"FireLens Fluent Bit Test","service":"access","time":"2020-01-24T21:25:12+09:00"}
{"countdown":2,"level":"info","msg":"FireLens Fluent Bit Test","service":"error","time":"2020-01-24T21:25:13+09:00"}
{"countdown":1,"level":"info","msg":"FireLens Fluent Bit Test","service":"access","time":"2020-01-24T21:25:14+09:00"}
```
