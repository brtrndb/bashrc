#!/bin/sh
# Bertrand B.

CONTAINERS=`docker ps -a -q -f "name=$1"`;
docker exec -it $CONTAINER bash;
