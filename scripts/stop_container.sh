#!/bin/bash
set -e

CONTAINER_NAME=flask-app
IMAGE_NAME=sravyabolla/simple-python-flask-app:latest
HOST_PORT=5000
CONTAINER_PORT=5000

echo "Checking for existing container..."
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping old container..."
    docker stop $CONTAINER_NAME || true
    echo "Removing old container..."
    docker rm $CONTAINER_NAME || true
    # Small wait to make sure port is released
    sleep 3
fi

echo "Pulling latest image..."
docker pull $IMAGE_NAME

echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $IMAGE_NAME



