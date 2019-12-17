# build stage
FROM golang:alpine AS build
ENV GO111MODULE=on
RUN apk -Uuv add git
ADD main.go .
RUN go get k8s.io/client-go@v0.16.4
RUN go get -u k8s.io/apimachinery@v0.16.4
ENV GO111MODULE=auto
RUN go build -o ./app

# final stage
FROM debian
COPY --from=build /app ./
ENTRYPOINT ./app
