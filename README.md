# Logitech Media Server

Docker image for Logitech Media Server (SqueezeCenter, SqueezeboxServer, SlimServer)

The Docker updates the system on restart to apply security and Linux updates.

To run LMS on unRAID:

docker run -d --name="LogitechMediaServer" \
--net="bridge" \
-p 3483:3483/tcp \
-p 9000:9000/tcp \
-p 9090:9090/tcp \
-e PUID="99" \
-e PGID="100" \
-v "/mnt/user/appdata/LogitechMediaServer":"/config":rw \
-v "/mnt/user/Music":"/music":rw \
-v "/etc/localtime":"/etc/localtime":ro \
logitechmediaserver

Changes:
2017-04-22
- Added PUID and PGID for proper appdata ownership settings for unRAID.
