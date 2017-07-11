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
-e TZ="America/New_York" \
-v "/mnt/user/appdata/LogitechMediaServer":"/config":rw \
-v "/mnt/user/Music":"/music":rw \
logitechmediaserver

Changes:

2017-07-11
- Add OpenSSL package.

2017-07-09
- Add perl packages for IO::Socket::SSL.

2017-05-19
- Fix time zone.

2017-05-12
- Update 7.9.1 to latest.

2017-05-07
- Upgrade LMS to 7.9.1.
- Some organizational changes.

2017-04-23
- Organization and code cleanup.

2017-04-22
- Added PUID and PGID for proper appdata ownership settings for unRAID.
