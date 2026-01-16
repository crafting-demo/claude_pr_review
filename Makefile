.PHONY: build test worker clean

VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)
LDFLAGS := -X 'main.version=$(VERSION)'

build:
	go build -ldflags "$(LDFLAGS)" ./...

test:
	go test ./...

worker:
	mkdir -p bin
	GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o bin/worker ./cmd/worker

clean:
	rm -rf bin
