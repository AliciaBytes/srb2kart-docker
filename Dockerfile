FROM debian:11.6-slim AS builder

# See: https://github.com/STJr/Kart-Public/releases
ARG SRB2KART_VERSION=1.6

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    unzip \
    build-essential \
    libpng-dev \
    zlib1g-dev \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libgme-dev \
    libopenmpt-dev \
    libcurl4-openssl-dev \
    nasm \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srb2kart \
    && mkdir -p /srb2kart-assets \
    && curl -L -o /tmp/srb2kart-v"${SRB2KART_VERSION}"-src.tar.gz https://github.com/STJr/Kart-Public/archive/refs/tags/v"${SRB2KART_VERSION}".tar.gz \
    && tar -xf /tmp/srb2kart-v"${SRB2KART_VERSION}"-src.tar.gz -C /tmp/ \
    && cp -r /tmp/Kart-Public-"${SRB2KART_VERSION}"/* /srb2kart/ \
    && curl -L -o /tmp/srb2kart-v"${SRB2KART_VERSION}"-assets.zip https://github.com/STJr/Kart-Public/releases/download/v"${SRB2KART_VERSION}"/AssetsLinuxOnly.zip \
    && unzip /tmp/srb2kart-v"${SRB2KART_VERSION}"-assets.zip -d /srb2kart-assets \
    && rm -rf /tmp/*

WORKDIR /srb2kart/src

RUN make -j"$(nproc)" LINUX64=1 NOUPX=1 \
    && ls /srb2kart/bin/Linux64/Release/lsdl2srb2kart

FROM debian:11.6-slim AS finished

ENV ROOM_ID=
ENV PASSWORD=

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libsdl2-2.0-0 \
    libsdl2-mixer-2.0-0 \
    libpng16-16 \
    libgme0 \
    libcurl4 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srb2kart

COPY --from=builder /srb2kart/bin/Linux64/Release/lsdl2srb2kart /usr/bin/srb2kart
COPY --from=builder /srb2kart-assets/* /srb2kart
COPY entrypoint.sh entrypoint.sh

RUN mkdir -p /addons /data /logs /luafiles \
    && ln -sf /addons /srb2kart/addons \
    && ln -sf /data /srb2kart/data \
    && ln -sf /logs /srb2kart/logs \
    && ln -sf /luafiles /srb2kart/luafiles \
    && chmod a+x entrypoint.sh \
    && groupadd -r srb2kart && useradd --no-log-init -r -g srb2kart srb2kart \
    && chown -R srb2kart /srb2kart entrypoint.sh

USER srb2kart

VOLUME /addons
VOLUME /data
VOLUME /logs
VOLUME /luafiles

EXPOSE 5029/udp

ENTRYPOINT ["./entrypoint.sh"]
