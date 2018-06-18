#!/bin/sh
# Bertrand B.

CONTAINERS=`docker ps -a -q`;
docker rm $CONTAINERS;
