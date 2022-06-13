#!/bin/sh
# Bertrand B.

CONTAINER=`docker ps -a -q -f "name=$1"`;
docker exec -it $CONTAINER bash;
