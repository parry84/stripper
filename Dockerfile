FROM alpine:3.14
LABEL maintainer="https://github.com/parry84/"

ENV EXIFTOOL_VERSION=12.60

RUN apk add --no-cache perl make
RUN apk add --no-cache qpdf
RUN cd /tmp \
	&& wget https://exiftool.org/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
    && CHECKSUM=`wget -O - https://exiftool.org/checksums.txt | grep SHA1\(Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz | awk -F'= ' '{print $2}'` \
    && echo "${CHECKSUM}  Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz" | /usr/bin/sha1sum -c -s - \
	&& tar -zxf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
    && cd Image-ExifTool-${EXIFTOOL_VERSION} \
    && cp -r exiftool lib /usr/local/bin \
    && cd .. \
	&& rm -rf Image-ExifTool-${EXIFTOOL_VERSION}

COPY ./entrypoint /entrypoint.sh

VOLUME /tmp

WORKDIR /tmp

ENTRYPOINT ["sh", "/entrypoint.sh"]
