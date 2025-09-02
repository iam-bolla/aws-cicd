#!/bin/bash
set -e

containerid=$(docker ps | awk 'NR==2 {print $1}')
docker rm -f "$containerid"



