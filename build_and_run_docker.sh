#!/bin/bash
#docker build --build-arg TAGS=$1 . -t new_computer
docker build . -t new_computer
docker images -a | grep none | awk '{ print $3; }' | xargs docker rmi -f
docker run -it new_computer bash

