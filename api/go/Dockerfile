FROM golang:1.19 AS build

WORKDIR /go-app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./

RUN go build -o ./app

# =================================================
FROM golang:1.19 AS production

WORKDIR /go-app

COPY --from=build /go-app/app ./
COPY --from=build /go-app/config.yaml ./

ENV APP_PORT=5000

EXPOSE 5000

ENTRYPOINT ["./app"]