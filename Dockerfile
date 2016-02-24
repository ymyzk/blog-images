FROM debian:jessie
MAINTAINER Yusuke Miyazaki <miyazaki.dev@gmail.com>

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list

RUN apt-get update \
        && apt-get install -y --no-install-recommends hhvm \
        && rm -rf /var/lib/apt/lists/*

COPY ./php.ini /etc/hhvm/
COPY ./server.ini /etc/hhvm/

EXPOSE 9000
ENTRYPOINT ["hhvm"]
CMD ["--config", "/etc/hhvm/php.ini", "--config", "/etc/hhvm/server.ini", "--mode", "server"]
