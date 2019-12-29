#!/usr/bin/env bash

if [[ "$1" = "" ]]; then
  echo  "AWSアカウントIDを第1引数に指定して下さい"
  exit 1
fi

if [[ "$2" = "" ]]; then
  echo  "TAGを第2引数に指定してください"
  exit 1
fi

ACCOUNT_ID="$1"
TAG="$2"
APP_NAME=firelens-fluentbit-sample-logrouter

$(aws ecr get-login --no-include-email --region ap-northeast-1)

docker build -t ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:latest -f Dockerfile .
docker tag ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:latest ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:${TAG}
docker push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:latest
docker push ${ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com/${APP_NAME}:${TAG}
