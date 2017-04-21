#!/bin/bash

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Configure user nobody to match unRAID's settings
export DEBIAN_FRONTEND="noninteractive"
usermod -u 99 nobody
usermod -g 100 nobody
usermod -d /home nobody
chown -R nobody:users /home

# Disable SSH, Syslog and Cron
rm -rf /etc/service/sshd /etc/service/cron /etc/service/syslog-ng /etc/my_init.d/00_regen_ssh_host_keys.sh

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

# Repositories
#add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
#add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
#curl -skL -o /etc/apt/sources.list http://tinyurl.com/lm2vf9a

# Install Dependencies
apt-get update -qq
apt-get install -qy lame faad flac sox perl wget sudo

#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################
# LMS
mkdir -p /etc/service/logitechmediaserver
cat <<'EOT' > /etc/service/logitechmediaserver/run
#!/bin/bash
chown -R nobody:users /config
squeezeboxserver --user nobody  --prefsdir /config/prefs --logdir /config/logs --cachedir /config/cache
EOT

chmod -R +x /etc/service/ /etc/my_init.d/

#########################################
##             INSTALLATION            ##
#########################################

# Install LMS
url="http://www.mysqueezebox.com/update/?version=7.9.0&revision=1&geturl=1&os=deb"
latest_lms=$(wget -q -O - "$url")
mkdir -p /sources
cd /sources
wget $latest_lms
lms_deb=${latest_lms##*/}
dpkg -i $lms_deb

chmod +x /etc/my_init.d/20_apt_update.sh

#########################################
##                 CLEANUP             ##
#########################################

# Clean APT install files
apt-get clean -y
rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*
