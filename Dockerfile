FROM phusion/baseimage:0.9.20

MAINTAINER dlandon

# Set correct environment variables
ENV DEBCONF_NONINTERACTIVE_SEEN="true" \
DEBIAN_FRONTEND="noninteractive" \
HOME="/root" \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
TERM="xterm"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
COPY 20_apt_update.sh /etc/my_init.d/

COPY install.sh /
RUN bash /install.sh

VOLUME /config /music
EXPOSE 3483 3483/udp 9000 9090
