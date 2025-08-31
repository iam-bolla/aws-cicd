#!/bin/bash
set -e

# Get running container IDs
container_ids=$(docker ps -q)

# Stop and remove containers if any exist
if [ -n "$container_ids" ]; then
  echo "Stopping and removing containers..."
  docker rm -f $container_ids
else
  echo "No running containers found."
fi

