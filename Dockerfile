# builder container
FROM golang:1.13-alpine AS builder

WORKDIR $GOPATH/src/demo

ADD . $GOPATH/src/demo/

RUN CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o helloarch .
RUN mv $GOPATH/src/demo/helloarch /

# application container
FROM alpine
WORKDIR /
RUN apk add --no-cache file && \
    rm -rf /var/cache/apk/*
COPY --from=builder /helloarch /helloarch
EXPOSE 8080
CMD ["/helloarch"]
