# build stage
FROM golang:alpine AS build
ADD main.go .
RUN go build -o ./app

# final stage
FROM debian
COPY --from=build /app ./
ENTRYPOINT ./app
