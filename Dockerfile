# build stage
FROM golang:alpine AS build
ENV GO111MODULE=on
RUN apk -Uuv add git
ADD main.go .
RUN go get k8s.io/client-go@@kubernetes-1.16.0
RUN go get -u k8s.io/apimachinery@@kubernetes-1.16.0
RUN go build -o ./app

# final stage
FROM debian
COPY --from=build /app ./
ENTRYPOINT ./app
