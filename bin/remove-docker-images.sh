#!/bin/bash
# Cleanup unused docker images
set -x


CONTAINERS=$(docker ps -a -q -f status=exited)
if [[ ! -z $CONTAINERS ]];
then
    docker rm -v $CONTAINERS;
fi;

IMAGES=$(docker images -q)

if [[ ! -z $IMAGES ]];
then
    docker rmi $IMAGES;
fi;

curl -s {{ docker_images_cleanup_dms}}
echo "Completed docker image cleanup."
