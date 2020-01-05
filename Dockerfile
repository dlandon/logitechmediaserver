FROM phusion/baseimage:0.11

LABEL maintainer="dlandon"

ENV	DEBCONF_NONINTERACTIVE_SEEN="true" \
	DEBIAN_FRONTEND="noninteractive" \
	DISABLE_SSH="true" \
	HOME="/root" \
	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TZ="Etc/UTC" \
	TERM="xterm"

ENV SLIMUSER="nobody"

COPY init /etc/my_init.d/
COPY run /etc/service/logitechmediaserver/

RUN rm -rf /etc/service/cron /etc/service/syslog-ng

RUN	apt-get update && \
	apt-get -y upgrade -o Dpkg::Options::="--force-confold" && \
	apt-get install -y lame faad flac sox perl wget tzdata pv && \
	apt-get install -y libio-socket-ssl-perl libcrypt-ssleay-perl &&\
	apt-get install -y openssl libcrypt-openssl-bignum-perl libcrypt-openssl-random-perl libcrypt-openssl-rsa-perl

RUN	url="http://www.mysqueezebox.com/update/?version=7.9.2&revision=1&geturl=1&os=deb" && \
	latest_lms=$(wget -q -O - "$url") && \
	mkdir -p /sources && \
	cd /sources && \
	wget $latest_lms && \
	lms_deb=${latest_lms##*/} && \
	dpkg -i $lms_deb

RUN	apt-get -y remove wget && \
	apt-get clean -y && \
	apt-get -y autoremove && \
	rm -rf /tmp/* /var/tmp/* && \
	chmod -R +x /etc/service/logitechmediaserver /etc/my_init.d/

VOLUME \
	["/config"] \
	["/music"]

EXPOSE 3483 3483/udp 9000 9090

CMD ["/sbin/my_init"]
