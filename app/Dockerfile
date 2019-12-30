FROM golang:1.13.5-alpine3.11 as build

WORKDIR /go/app

COPY . .

RUN set -x && \
  apk update && \
  apk add --no-cache git && \
  go build -o fluentbit-test

FROM alpine:3.11

WORKDIR /app

COPY --from=build /go/app/fluentbit-test .

RUN set -x && \
  addgroup go && \
  adduser -D -G go go && \
  chown -R go:go /app/fluentbit-test

CMD ["./fluentbit-test"]