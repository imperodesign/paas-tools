# Impero PaaS Tools

This repo contains everything you need to:
- set up the Impero PaaS infrastructure from scratch on [AWS]()
- update Impero PaaS infrastructure
- create, deploy, and destroy an application

Impero [PaaS](https://en.wikipedia.org/wiki/Platform_as_a_service) infrastructure is built on top of [Deis](http://deis.io/). Read more about [Deis components](http://docs.deis.io/en/latest/understanding_deis/components/)

## Repository Organisation

### bin
This folder contains `deis` and `deisctl` binary app. `deis` is a “dev” tool, used to deploy and scale applications to a Deis platform. `deisctl` is an “ops” tool, used to configure and manage the Deis platform itself.

### deis
This folder contain the infrastructure provisioning files, both for staging and production clusters.

### .deis
This folder contain deis units.


## Bootstrap from scratch the infrastructure on AWS

### Prerequisites
You need `python`, `pip` and `make` installed. You also need a valid AWS credential.

#### Install
In order to start working with Amazon’s API, let’s install [awscli]():
```
$ pip install awscli
```
We’ll also need PyYAML for the Deis AWS provision script to run:
```
$ pip install pyyaml
```

#### Configure aws-cli
```sh
$ aws configure
# AWS Access Key ID [None]: ***************
# AWS Secret Access Key [None]: ************************
# Default region name [None]: eu-east-1
# Default output format [None]:
```

#### SSH Key
Generate an admin `deis` ssh key (and store this in a safe place):
```sh
ssh-keygen -q -t rsa -f ~/.ssh/deis -N '' -C deis
```
then upload it on AWS
```sh
aws ec2 import-key-pair --key-name deis --public-key-material file://~/.ssh/deis.pub
```
then add it to your SSH agent
```sh
ssh-add ~/.ssh/deis
```
If your SSH agent is not running, run:
```sh
$ `eval `ssh-agent -s`
```

#### Link Deis units
```
ln -s $(pwd)/Devs ~/.deis
```

#### Build the cluster
To build the production cluster go to `deis/prd`, for the staging one go to `deis/stg`.
```sh
cd deis/prd
# or
cd deis/stg
```

##### Configure number of nodes per cluster
```sh
# Minimum value is 3
export DEIS_NUM_INSTANCES=3
```

##### Generate a new URL discovery
Default is 3 nodes per cluster, which is the minimum. If you want change this value, run:
```sh
make discovery-url
```

##### Run the provisioning script
```sh
$ cd contrib/aws
$ ./provision-aws-cluster.sh <stack-name>

# Creating CloudFormation stack <stack-name>
# ...
# Waiting for instances to be created...
# Waiting for instances to be created... CREATE_IN_PROGRESS
# ...
# Waiting for instances to pass initial health checks...
# ...
# Your Deis cluster has been successfully deployed to AWS CloudFormation and is started.
# ...
```

##### Install Deis platform
Find the public IP address of one of your nodes, and export it to the DEISCTL_TUNNEL environment variable
```sh
$ export DEISCTL_TUNNEL=xxx.xxx.xxx.xxx
```
then add the `deis` SSH key to Deis so it can connect to remote hosts
```sh
$ deisctl config platform set sshPrivateKey=~/.ssh/deis
```
and finally tell the controller which domain name we are deploying applications under
```sh
$ deisctl config platform set domain=example.com
# prd.paas.impero.me / stg.paas.impero.me
```
Once finished, run this command to provision the Deis platform, and go to make a coffe (it takes 5-10 minutes):
```sh
deisctl install platform && deisctl start platform
```

## References
- [Deis](http://deis.io/) - Open source PaaS that makes it easy to deploy and manage applications on your own servers
- [CoreOS](https://coreos.com/) - Minimal operating system that supports popular container systems out of the box
- [Fleet](https://github.com/coreos/fleet) - A scheduling backend included with CoreOS
- [Docker](https://www.docker.com/) - Containers wrap up a piece of software in a complete filesystem
- [PostgreSQL](http://www.postgresql.org/) - Object-relational database system
- [Git](https://git-scm.com/) - Distributed version control system
- [Ceph](http://ceph.com/) - Distributed object store and file system designed to provide excellent performance, reliability and scalability
- [Nginx](http://nginx.org/) - HTTP and reverse proxy server
- [Logspout](https://github.com/gliderlabs/logspout) - Log routing for Docker container logs
