#!/bin/bash
#
# 30_firstrun.sh
#

# Create prefs directory if it doesn't exist
if [ ! -d /config/prefs ]; then
	mkdir /config/prefs
	mkdir /config/prefs/plugin
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

# Configure user nobody to match Unraid's settings
PUID=${PUID:-99}
PGID=${PGID:-100}
usermod -u $PUID nobody
usermod -g $PGID nobody
usermod -d /config nobody
chown -R nobody:users /config
chmod -R go+rw /config
