#!/bin/bash

docker run -d --name="LogitechMediaServer" \
--net="bridge" \
-p 3483:3483/tcp \
-p 9000:9000/tcp \
-p 9090:9090/tcp \
-v "/mnt/user/appdata/LogitechMediaServer":"/config":rw \
-v "/etc/localtime":"/etc/localtime":ro \
logitechmediaserver
