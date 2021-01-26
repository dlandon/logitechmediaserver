FROM phusion/baseimage:bionic-1.0.0 as builder

LABEL maintainer="dlandon"

ENV	DEBCONF_NONINTERACTIVE_SEEN="true" \
	DEBIAN_FRONTEND="noninteractive" \
	DISABLE_SSH="true" \
	HOME="/root" \
	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TZ="Etc/UTC" \
	TERM="xterm" \
	SLIMUSER="nobody" \
	LMS_VERSION="8.1.0"

FROM builder as build1
COPY init /etc/my_init.d/
COPY run /etc/service/logitechmediaserver/

RUN rm -rf /etc/service/cron /etc/service/syslog-ng

FROM build1 as build2
RUN	apt-get update && \
	apt-get -y upgrade -o Dpkg::Options::="--force-confold" && \
	apt-get install -y lame faad flac sox perl wget tzdata pv && \
	apt-get install -y libio-socket-ssl-perl libcrypt-ssleay-perl &&\
	apt-get install -y openssl libcrypt-openssl-bignum-perl libcrypt-openssl-random-perl libcrypt-openssl-rsa-perl

FROM build2 as build3
RUN	url="http://www.mysqueezebox.com/update/?version=${LMS_VERSION}&revision=1&geturl=1&os=deb" && \
	latest_lms=$(wget -q -O - "$url") && \
	mkdir -p /sources && \
	cd /sources && \
	wget $latest_lms && \
	lms_deb=${latest_lms##*/} && \
	dpkg -i $lms_deb

FROM build3 as build4
RUN	apt-get -y remove wget && \
	apt-get clean -y && \
	apt-get -y autoremove && \
	rm -rf /tmp/* /var/tmp/* && \
	chmod -R +x /etc/service/logitechmediaserver /etc/my_init.d/

FROM build4 as build5
VOLUME \
	["/config"] \
	["/music"]

FROM build5 as build6
EXPOSE 3483 3483/udp 9000 9090

FROM build6
CMD ["/sbin/my_init"]
