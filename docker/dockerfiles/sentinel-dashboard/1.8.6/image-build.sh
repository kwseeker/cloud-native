#!/bin/bash

docker build -t kwseeker/sentinel-dashboard:1.8.6 .
# 需要先 docker login
docker push kwseeker/sentinel-dashboard:1.8.6