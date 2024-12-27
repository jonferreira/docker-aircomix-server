# 1. alpine 설치 (패키지 업데이트 + 만든사람 표시)
FROM php:7.4-fpm-alpine
RUN apk update

# 언어 설정
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# TimeZone 설정
ENV TZ Europe/Lisbon

# 2. apache php 설치
RUN apk add php7-apache2 php7-zip apache2-utils php7-pear php7-dev

# 3. 필요파일 복사
COPY ./comix-server /data/comix-server
COPY ./conf/comix.conf /etc/apache2/conf.d
COPY ./docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

# 4. 아파치 수정
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
RUN mkdir -p /run/apache2

# 5. 초기실행
VOLUME ["/data/manga"]
ENV PASSWORD 1234
EXPOSE 31257
ENTRYPOINT /docker-entrypoint.sh
