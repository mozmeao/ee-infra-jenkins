#!/bin/bash
# Cleanup unused docker images
set -x
docker system prune -a -f

curl -s {{ docker_images_cleanup_dms}}
echo "Completed docker image cleanup."
