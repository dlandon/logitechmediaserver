#!/bin/bash

# Disable SSH, Syslog, Cron and Regen Host Key
rm -rf /etc/service/sshd /etc/service/cron /etc/service/syslog-ng /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Dependencies
apt-get update
apt-get install -y lame faad flac sox perl wget sudo

# Setup LMS startup
mkdir -p /etc/service/logitechmediaserver
cat <<'EOT' > /etc/service/logitechmediaserver/run
#!/bin/bash
#

# Create prefs directory if it doesn't exist
if [ ! -d /config/prefs ]; then
	mkdir /config/prefs
fi

# Create logs directory if it doesn't exist
if [ ! -d /config/logs ]; then
	mkdir /config/logs
fi

# Create cache directory if it doesn't exist
if [ ! -d /config/cache ]; then
	mkdir /config/cache
fi

# Create playlists directory if it doesn't exist
if [ ! -d /config/playlists ]; then
	mkdir /config/playlists
fi

# Configure user nobody to match unRAID's settings
PUID=${PUID:-99}
PGID=${PGID:-100}
usermod -u $PUID nobody
usermod -g $PGID nobody
usermod -d /config nobody
chown -R nobody:users /config

# Start squeezeboxserver
squeezeboxserver --user nobody  --prefsdir /config/prefs --logdir /config/logs --cachedir /config/cache
EOT

chmod -R +x /etc/service/ /etc/my_init.d/

# Install LMS
url="http://www.mysqueezebox.com/update/?version=7.9.0&revision=1&geturl=1&os=deb"
latest_lms=$(wget -q -O - "$url")
mkdir -p /sources
cd /sources
wget $latest_lms
lms_deb=${latest_lms##*/}
dpkg -i $lms_deb

chmod +x /etc/my_init.d/20_apt_update.sh

# Clean APT install files
apt-get clean -y
