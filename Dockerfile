
FROM ubuntu:16.10

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 11753


RUN apt-get update && apt-get install --no-install-recommends -y  tar\
	wget \
	cmake \
	libsdl2-dev \
	libsdl2-ttf-dev \
	pkg-config \
	g++ \
	gcc \
	libjansson-dev \
	libspeex-dev \
	libspeexdsp-dev \
	libcurl4-openssl-dev \
	libcrypto++-dev \
	libfontconfig1-dev \
	libfreetype6-dev \
	libpng-dev \
	libzip-dev \
	git \
	libssl-dev

ENV GIT_SSL_NO_VERIFY=true

RUN 	mkdir -p /openrct2/config /openrct2/original_files /openrct2/save && \
	git clone https://github.com/OpenRCT2/OpenRCT2.git /openrct2/src && \
	mkdir /openrct2/src/build

WORKDIR /openrct2/src/build
RUN 	cmake /openrct2/src && \
	make && \
	make g2 && \
	cp g2.dat /openrct2/src/data/g2.dat && \
	ln -s /openrct2/src/data /openrct2/src/build/data

ADD ./docker-entrypoint.sh docker-entrypoint.sh

CMD ./docker-entrypoint.sh
