#!/bin/bash
# Clean up docker reserved space due to bug https://github.com/docker/docker/issues/3182

set -xe

# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi $(docker images -q)

service docker stop
service docker start
service jenkins restart
