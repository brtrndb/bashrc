#!/bin/bash
# Bertrand B.

CONTAINERS=`docker ps -a -q`;
docker rm $CONTAINERS;
