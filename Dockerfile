FROM debian:stable-slim AS builder

WORKDIR /build

RUN apt update && apt upgrade
RUN apt install -y curl jq xz-utils

RUN curl -L $(curl --silent "https://api.github.com/repos/frectonz/sql-studio/releases/latest" | jq -r ".assets[] | select(.name == \"sql-studio-x86_64-unknown-linux-gnu.tar.xz\") | .browser_download_url") | tar -xJf - --strip-components=1 sql-studio-x86_64-unknown-linux-gnu/sql-studio

FROM debian:stable-slim

COPY --from=builder /build/sql-studio /sql-studio

ENTRYPOINT [ "/sql-studio" ]