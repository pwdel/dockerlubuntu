# Docker on Lubuntu

## Objective

The purpose of this repo is to test out Docker on Lubuntu.  I'm sure it probably works, but we'll just install and run it just to make absolute certain.

## Setup

### Installing Docker

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