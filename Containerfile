FROM rust as build-env
WORKDIR /app
COPY . /app
RUN cargo build --release

FROM gcr.io/distroless/cc
COPY --from=build-env /app/target/release/blog /
COPY --from=build-env /app/templates /
COPY --from=build-env /app/Rocket.toml /
CMD ["./blog"]