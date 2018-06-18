#!/bin/sh
# Bertrand B.

IMAGES=`docker images -q`;
docker rmi $IMAGES;
