# Logitech Media Server

Docker image for Logitech Media Server (SqueezeCenter, SqueezeboxServer, SlimServer)

The Docker updates the system on restart to apply security and Linux updates.

To run LMS on Unraid:

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

2019-03-02
- Update to latest Nightly Build (7.9.2).

2018-12-08
- Update to latest Nightly Build (7.9.2).

2018-10-27
- Update to latest Nightly Build (7.9.2).

2018-08-11
- Update to latest Nightly Build (7.9.2).

2018-05-13
- Update to latest Nightly Build.

2018-03-03
- Update to latest Nightly Build.
- Update to phusion 10.0.

2017-12-31
- Update to latest Nightly Build.

2017-11-30
- Update base image.

2017-09-26
- Change to dlandon/baseimage - phusion 9.22.

2017-09-25
- Added pv (pipeview) required for latest Spotty.

2017-09-24
- Modifications to dockerfile for auto build.

2017-07-12
- Add perl OpenSSL packages.

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
- Added PUID and PGID for proper appdata ownership settings for Unraid.
