# Docker on Lubuntu

## Objective

The purpose of this repo is to test out Docker on Lubuntu.  I'm sure it probably works, but we'll just install and run it just to make absolute certain.

Note, we followed [this guide by Anca Iordache](https://www.docker.com/blog/containerized-python-development-part-1/) in building the following demonstration.

## Setup

### Installing Docker Engine

There are two parts to Docker, Docker Engine vs. Docker Compose.

* docker-compose cli can be used to manage a multi-container application, under the microservices paradigm.
* docker-cli is used when managing individual containers.

We're interested in just the regular docker engine, docker-cli.

Take a look at the [Installing Docker on Ubuntu Documentation](https://docs.docker.com/engine/install/ubuntu/).  Lubuntu is essentially a modified version of Ubuntu with less fancy graphics, so the same procedure for installing Docker on Ubuntu should work for Lubuntu.

Note the documentation states:

> To install Docker Engine, you need the 64-bit version of one of these Ubuntu versions:
>    Ubuntu Groovy 20.10
>    Ubuntu Focal 20.04 (LTS)
>    Ubuntu Bionic 18.04 (LTS)
>    Ubuntu Xenial 16.04 (LTS)

To check our underlying version of Ubuntu, we do:

```
~ : lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 20.04.2 LTS
Release:        20.04
Codename:       focal
```

As we can see clearly above, Lubuntu "thinks," that it is Ubuntu 20.04, focal - so we should be good to go with Docker.

Sure enough, attempting to install Docker yields:

```
~ : sudo apt-get install docker.io 

Setting up docker.io (19.03.8-0ubuntu1.20.04.2) ...                        
Adding group `docker' (GID 130) ...                                        
Done. 

```

### Testing out Docker on Lubuntu

To test out Docker, we should look at containerizing and actual app. For this experiment, we will containerize a Python app [per the tutorial given here](https://www.docker.com/blog/containerized-python-development-part-1/), which is basically a simple Hello World Flask App.

#### Building the App

The app will be a very simple Python Flask app, 'server.py' as shown below:

```
from flask import Flask
server = Flask(__name__)

@server.route("/")
 def hello():
    return "Hello World!"

if __name__ == "__main__":
   server.run(host='0.0.0.0') 

```

In order to run this app, we will require some dependencies, or 'requirements.'  To build this we can use the command:

```
pip3 freeze > requirements.txt
```

Of course, this method of adding requirements is very heavy-handed.  Basically what ```pip3 freeze``` does is automatically grab every single requirement in operation, and throw it into that file.  [Tomas Arni Jonasson](https://medium.com/@tomagee/pip-freeze-requirements-txt-considered-harmful-f0bce66cf895) discussed in a Medium article that this method is considered harmful and recommends hand-crafting one's own requirements document.

Another reason for doing this besides harmful or dead dependencies, is to create lighter weight Docker images. Docker is basically a dependency-installation machine, and the fewer dependencies we have to install, the less cost and the lighter weight a particular docker image is going to be, which can cut down on server deployment time and cost (althought depending upon your project needs, this may be overkill).

For now, we'll just use a hand crafted version of this app, which looks like the following:


Let's also check our version of python:

```
$ python3 --version

$ Python 3.8.5
```

### Testing the App

We can test the app out by running:

```
python3 server.py
```

...and then visiting:

> http://0.0.0.0:5000/

When we visit that address, we shold see a message on the screen that says, "Hello World!"

Now, we need to understand which version of Flask is installed in order to build our requirements file.

```
$ python3

>> import flask
>> flask.__version__
                                             
'1.1.2'        

```

### Writing the Dockerfile

A dockerfile is essentially a set of Dockerease instructions on how to build an app image.

Once an image is built, it can then "run" on a container.

So currently the structure of our app folder is as follows:

```
app
├─── requirements.txt
└─── src
     └─── server.py
```

We have to add a dockerfile which includes instructions on how to build the app and environment according to the requirements.txt file.

The dockerfile will do the following, in psuedocode:

```
# set base image (host OS)

# set the working directory in the 
# copy the dependencies file to the 

# install dependencies

# copy the content of the local src directory to the working directory

# command to run on container start

```

The way we wrote our Dockerfile is so that the working directory is within the same location as the requirements.txt.

The Dockerfile can be found [here](/app/Dockerfile).

```
app
├─── requirements.txt
├─── Dockerfile
└─── src
     └─── server.py
```


### Building the Docker Image

So now, to run the dockerfile to create an image you do:

```
docker build -t myimage .
```

However, upon doing so, without any further setup you will recieve an error:

> Got permission denied while trying to connect to the Docker daemon socket

This is because you have to have root permissions in order to run a docker command.  Therefore, either add your current user to a group with root permissions, or run with sudo.  Then, you will get somthing along the lines of:

> 3.8: Pulling from library/python

> b9a857cbf04d: Pull complete   

We can then look at our image on our local machine as follows:

| REPOSITORY | TAG    | IMAGE ID     | CREATED       | SIZE  |
|------------|--------|--------------|---------------|-------|
| myimage    | latest | 05a6228906d9 | 7 minutes ago | 893MB |
| python     | 3.8    | 40251af0bd62 | 3 days ago    | 883MB |


Of course, 893MB is quite large and there are ways that we can slim this down.  However we can go over, "slimming down Docker builds," later in the article.

### Running the Container

So the next step would be to run the container and then run the app within the container.  To do so, we execute:

```
sudo docker run -d -p 5000:5000 myimage
```
Which yields:

> 0db6b46921c1bc829d91cb8067fee8c3f2295a6bd3d898ee4766224ce1556c15

Note that in the above, the options:

* -d indicates, "detached," mode, which means we have to specifically call out the container when we run commands on that specific server. The opposite of this would be, "foreground," mode, which would point all docker commands towards that specific server, for convenience purposes.
* -p indicates publishings all exposed ports to the host interfaces. So basically, [container networking](https://docs.docker.com/config/containers/container-networking/) is used because within the microservices paradigm, different apps may talk to each other while deployed on different servers. These servers each have a unique IP address, under standard ISO networking procedure, so the IP addresses are used on a local instance to simulate this structure. In short, we need to expose the external port in order to be able to connect to the container.

So upon running the container with this command, we can look at the container with:

```
sudo docker ps
```

Which yields:


| CONTAINER ID | IMAGE   | COMMAND              | CREATED        | STATUS        | PORTS                  | NAMES         |
|--------------|---------|----------------------|----------------|---------------|------------------------|---------------|
| 0db6b46921c1 | myimage | "python ./server.py" | 31 minutes ago | Up 31 minutes | 0.0.0.0:5000->5000/tcp | sweet_wescoff |

By curling or visiting the localhost address, we can see our, "Hello World," output result.

```
$ curl http://localhost:5000   

Hello World!

```

### Slimming Down the Container Design





To do next:




* choice of base image
* instruction order
* briefly discuss multi-stage builds
* try slim download of python