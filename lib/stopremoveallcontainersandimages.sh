#!/usr/bin/env bash
set -euo pipefail

docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker rmi $(docker images --format "{{.Repository}}" | grep 'bsdock')