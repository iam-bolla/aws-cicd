#!/bin/bash
set -e

containerid=$(docker ps -q | head -n 1)

if [ -n "$containerid" ]; then
  echo "Removing container: $containerid"
  docker rm -f "$containerid"
else
  echo "No running container found."
fi





