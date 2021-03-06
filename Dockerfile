FROM ubuntu:16.04

ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
    && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y --no-install-recommends tzdata wget \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && wget http://dl-cdn.oray.com/hsk/linux/phddns-5.0.0-amd64.deb \
    && dpkg -i phddns-5.0.0-amd64.deb \
    && rm phddns-5.0.0-amd64.deb \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y

COPY run.sh .

CMD /sbin/init
