#!/bin/bash
# Bertrand B.

CONTAINERS=`docker ps -a -q`;
IMAGES=`docker images -q`;
docker stop $CONTAINERS && docker rm $CONTAINERS && docker rmi $IMAGES;
