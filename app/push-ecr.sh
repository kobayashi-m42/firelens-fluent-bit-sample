#!/usr/bin/env bash

if [[ "$1" = "" ]]; then
  echo  "AWSアカウントIDを第1引数に指定して下さい"
  exit 1
fi

if [[ "$2" = "" ]]; then
  echo  "ECRのリポジトリ名を第2引数に指定してください"
  exit 1
fi

cd app

ACCOUNT_ID="$1"
APP_NAME="$2"

aws ecr get-login-password | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com

docker build -t ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:latest -f Dockerfile .
docker push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:latest

cd ../
