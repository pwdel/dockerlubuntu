#!/usr/bin/env bash
echo "Set imageName and containerName"
imageName=xx:my-image
containerName=my-container

echo "build the imageName using Dockerfile."
docker build -t $imageName -f Dockerfile  .

echo "Delete old container..."
docker rm -f $containerName

echo "Run new container..."
docker run -d -p 5000:5000 --name $containerName $imageName