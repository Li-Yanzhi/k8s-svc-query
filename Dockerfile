# build stage
FROM golang:alpine AS build
ADD main.go .
RUN go get k8s.io/client-go/...
RUN go get -u k8s.io/apimachinery/...
RUN go build -o ./app

# final stage
FROM debian
COPY --from=build /app ./
ENTRYPOINT ./app
