#!/bin/bash
set -e

# Stop and remove old container if exists
if [ "$(docker ps -aq -f name=flask-app)" ]; then
    docker stop flask-app || true
    docker rm flask-app || true
fi

# Run new container
docker run -d --name flask-app -p 5000:5000 sravyabolla/simple-python-flask-app:latest


