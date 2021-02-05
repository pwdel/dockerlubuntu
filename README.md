# Docker on Lubuntu

## Objective

The purpose of this repo is to test out Docker on Lubuntu.  I'm sure it probably works, but we'll just install and run it just to make absolute certain.

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

### Building the Dockerfile

A dockerfile is essentially a set of Dockerease instructions on how to build an app image.

Once an image is built, it can then "run" on a container.

So currently the structure of our app folder is as follows:

```
app
├─── requirements.txt
└─── src
     └─── server.py
```



To do next:

* talk about dockerfile
* build image
* look at image in local image store
* run the container
* choice of base image
* instruction order
* briefly discuss multi-stage builds
* 