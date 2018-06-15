#!/bin/bash
# Bertrand B.

IMAGES=`docker images -q`;
docker rmi $IMAGES;
