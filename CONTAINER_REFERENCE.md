Container Restart Reference


# Various Individual Commands - List, Stop Images and Processes

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

# to build using docker-compose

$ sudo docker-compose build

# to run containers using docker-compose

$ sudo docker-compose up

# to turn all containers off using docker-compose

$ sudo docker-compose down

```


# Logging in to Container, Build In Detached Mode

```

# Log Into Docker Container as Bash

$ sudo docker run --rm -it app_name bash

Example

$ sudo docker run --rm -it hello_flask bash

# Docker Compose Production File, Build in Detached Mode

$ sudo docker-compose -f <production_compose.yml> up -d --build

Example

$ sudo docker-compose -f docker-compose.prod.yml up -d --build


# Tag Image (Kind of Like Duplicating With Different Name)

$ sudo docker tag <image> <tagname>

Example

$ sudo docker tag 35b4695ba3f3 registry.heroku.com/pure-everglades-62431/web

$ sudo docker tag hello_flask registry.heroku.com/pure-everglades-62431/web

# Push Image to Registry

$ sudo docker push <registry name>

Example

$ sudo docker push registry.heroku.com/pure-everglades-62431/web

# On Heroku, Release Container

$ heroku container:release web

```


# Shell Scripts

```

* Making a Shell Script Executable

chmod +x script-name-here.sh

* Executing Shell Script

sudo ./script-name-here.sh
```


# Running Commands Within Docker

```
# Running a Command Within Docker

$ sudo docker-compose exec web python example.py example_function

Example:

$ sudo docker-compose exec web python manage.py seed_db

# Running Bash Within Docker

sudo docker run --rm -it image_name bash

Example

$ sudo docker run --rm -it hello_flask bash

# Running Bash within Existing Container

$ sudo docker exec -it CONTAINER_NAME /bin/bash

Example

sudo docker exec -it hello_flask /bin/bash


```

# Rebuild and Check on Development on Local
```
This is needed because we have to specify a port in order to inspect within localhost.

Example

1. sudo docker-compose -f docker-compose.yml up -d --build
2. visit localhost:5000

```

# Rebuild and Release to Production on Heroku
```
Example

1. sudo docker-compose -f docker-compose.prod.yml up -d --build
2. sudo docker tag hello_flask registry.heroku.com/pure-everglades-62431/web
3. sudo docker push registry.heroku.com/pure-everglades-62431/web
4. heroku container:release web

```

# psql Scripts

```
Connect via Docker to a PSQL database...

$ sudo docker-compose exec db psql --username=hello_flask --dbname=hello_flask_dev                                        

psql (13.1)                                                                                                                                                                      
Type "help" for help.                                                                                                                                                            
                                                                                                                                                                                 

Example

```
sudo docker exec -it db psql -d userlevels_flask_dev -U userlevels_flask
```
Generalized this is:

```
sudo docker exec -it DOCKERNAME psql -d DATABASENAME -U USERNAME
```

* connect to database

hello_flask_dev=# \c hello_flask_dev

* List databases

\l

* List tables

\dt

* Describe table

\d table_name

* List Schema

\dn

* List Functions

\df

* Get help

\?

Exit

\q

```

# Running Flask Shell in Currently Running Container

Login to currently running container:

```
$ sudo docker exec -it NAME /bin/bash

$ sudo docker exec -it flask /bin/bash
```

From within the container or environment:

```
$ flask shell


```
More info:

https://flask.palletsprojects.com/en/1.1.x/cli/#cli
