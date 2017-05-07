FROM phusion/baseimage:0.9.20

MAINTAINER dlandon

ENV \
	DEBCONF_NONINTERACTIVE_SEEN="true" \
	DEBIAN_FRONTEND="noninteractive" \
	DISABLESSH="true" \
	HOME="/root" \
	LC_ALL="C.UTF-8" \
	LANG="en_US.UTF-8" \
	LANGUAGE="en_US.UTF-8" \
	TERM="xterm" \
	SLIMUSER="nobody"

COPY 20_apt_update.sh /etc/my_init.d/
COPY run /etc/service/logitechmediaserver/

RUN \
	# Disable Cron, Syslog
	rm -rf /etc/service/cron /etc/service/syslog-ng && \

	# Install Dependencies
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y dist-upgrade && \
	apt-get install -y lame faad flac sox perl wget && \

	# Install LMS
	url="http://www.mysqueezebox.com/update/?version=7.9.1&revision=1&geturl=1&os=deb" && \
	latest_lms=$(wget -q -O - "$url") && \
	mkdir -p /sources && \
	cd /sources && \
	wget $latest_lms && \
	lms_deb=${latest_lms##*/} && \
	dpkg -i $lms_deb && \
	apt-get -y remove wget && \

	chmod -R +x /etc/service/logitechmediaserver /etc/my_init.d/ && \

	# Clean APT install files
	apt-get clean -y

VOLUME /config /music
EXPOSE 3483 3483/udp 9000 9090

CMD ["/sbin/my_init"]
