FROM lsiobase/alpine:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="gdunstone"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	ca-certificates \
	rtorrent \
	screen

# add local files
COPY root/ /

# ports and volumes
EXPOSE 51413
EXPOSE 6881
VOLUME /torrents /downloads
