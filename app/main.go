package main

import (
	"time"

	log "github.com/sirupsen/logrus"
)

func main() {
	count := 10
	for count > 0 {
		log.SetFormatter(&log.JSONFormatter{
			TimestampFormat: time.RFC3339,
		})

		service := "access"
		if count%2 == 0 {
			service = "error"
		}

		log.WithFields(log.Fields{
			"countdown": count,
			"service":   service,
		}).Info("FireLens Fluent Bit Test")

		time.Sleep(1 * time.Second)
		count--
	}
}
