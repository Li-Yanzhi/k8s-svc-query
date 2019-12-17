# build stage
FROM golang:alpine AS build
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
ADD main.go .
RUN go get k8s.io/client-go/...
RUN go get -u k8s.io/apimachinery/...
RUN go build -o ./app

# final stage
FROM debian
COPY --from=build /app ./
ENTRYPOINT ./app
