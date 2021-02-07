Container Restart Reference


* Various Individual Commands

```
# to list containers

$ sudo docker ps -a 

# to stop containers

$ docker stop 0db6b46921c1

# to delete containers

$ docker rm 0db6b46921c1

# to list images

$ sudo docker images -a

# to delete images

$ sudo docker rmi 05a622890

```

* Making a Shell Script Executable

chmod +x script-name-here.sh

* Executing Shell Script

sudo ./script-name-here.sh