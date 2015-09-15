#!/bin/bash
# Clean up docker reserved space due to bug https://github.com/docker/docker/issues/3182

set -x

# Delete all containers
docker rm $(docker ps --filter=[status=exited] -a -q)

# Delete all images
docker rmi $(docker images -q -a)

service docker stop
service docker start
service jenkins restart
