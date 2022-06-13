#!/bin/sh
# Bertrand B.

CONTAINERS=`docker ps -a -q`;
docker stop $CONTAINERS && docker rm $CONTAINERS;
