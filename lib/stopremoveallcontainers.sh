#!/usr/bin/env bash
echo "This script will exit immediately if a command exits with a non-zero status."
echo "The return value of the pipeline is the value of the last command to exit with a non-zero status."
set -euo pipefail

echo "Stopping all Docker Containers."
echo "stop $(docker ps -aq)"
docker stop $(docker ps -aq)

echo "Removing all Docker Containers."
echo "rm $(docker ps -aq)"
docker rm $(docker ps -aq)
