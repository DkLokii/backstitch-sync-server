FROM rust:1.75-slim AS builder

WORKDIR /app

COPY . .

RUN cargo build --release

FROM debian:bookworm-slim

WORKDIR /app

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/target/release/backstitch-sync-server .

EXPOSE 8085

CMD ["./backstitch-sync-server", ".", "8085", "3000", "release"]