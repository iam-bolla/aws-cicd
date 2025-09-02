#!/bin/bash
set -e

CONTAINER_NAME=flask-app
IMAGE_NAME=sravyabolla/simple-python-flask-app:latest
HOST_PORT=5000
CONTAINER_PORT=5000

echo "=== Checking for existing container ($CONTAINER_NAME) ==="
if [ "$(docker ps -aq -f name="^${CONTAINER_NAME}$")" ]; then
    echo "Stopping old container..."
    docker stop "$CONTAINER_NAME" || true
    echo "Removing old container..."
    docker rm "$CONTAINER_NAME" || true
    sleep 2
fi

echo "=== Checking port $HOST_PORT usage ==="
PID=$(lsof -ti tcp:$HOST_PORT || true)
if [ -n "$PID" ]; then
    echo "Port $HOST_PORT still in use by PID $PID. Killing it..."
    kill -9 $PID || true
    sleep 2
fi

echo "=== Pulling latest image: $IMAGE_NAME ==="
docker pull "$IMAGE_NAME"

echo "=== Starting new container ==="
docker run -d --name "$CONTAINER_NAME" -p $HOST_PORT:$CONTAINER_PORT "$IMAGE_NAME"

echo "Deployment complete! 🚀"





