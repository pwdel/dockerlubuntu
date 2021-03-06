#!/usr/bin/env bash
echo "This script will exit immediately if a command exits with a non-zero status."
echo "The return value of the pipeline is the value of the last command to exit with a non-zero status."
set -euo pipefail

echo "Removing all Docker Images."
echo "rmi -f $(docker images -a -q)"
docker rmi -f $(docker images -a -q)