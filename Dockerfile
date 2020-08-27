FROM library/rust:1-alpine as builder

RUN apk add libc-dev make

COPY Cargo.toml Makefile ./
COPY src/ ./src/

RUN make
RUN strip /target/release/ping-exporter

FROM alpine:latest

WORKDIR /
COPY --from=builder /target/release/ping-exporter ./

ENTRYPOINT ["/ping-exporter"]
