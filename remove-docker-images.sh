#!/bin/bash
# Clean up docker reserved space due to bug https://github.com/docker/docker/issues/3182

set -xe
echo 'Removes all docker images'
docker rm `docker ps -a -q`
service docker stop
rm -rf /var/lib/docker/devicemapper
service docker start
service jenkins restart
