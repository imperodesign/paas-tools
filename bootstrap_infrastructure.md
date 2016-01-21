## Bootstrap from scratch the infrastructure on AWS

### Prerequisites
You need `python`, `pip`, `git`, and `make` installed. You also need a valid AWS credential.

#### Install
In order to start working with Amazon’s API, let’s install [awscli](https://aws.amazon.com/cli/):
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
and finally tell the controller which domain name we are deploying applications under.
```sh
$ deisctl config platform set domain=example.com
# prd.paas.impero.me / stg.paas.impero.me
```
Once finished, run this command to provision the Deis platform, and go to make a coffe (it takes 5-10 minutes):
```sh
deisctl install platform && deisctl start platform
```

##### Create the superuser
```sh
$ deis register http://deis.example.com
# username: impero
# password:
# password (confirm):
# email: devs@imperodesign.com
# Registered impero
# Logged in as impero
```

#### Upload superuser SSH Public Key
First create a superuser SSH key (make a copy and store it in a safe place)
```sh
$ ssh-keygen -t rsa -b 4096 -C "devs@imperodesign.com"
# Enter file in which to save the key (/Users/jacopodaeli/.ssh/id_rsa): /Users/jacopodaeli/.ssh/impero_deis_rsa
```
then upload it
```sh
deis keys:add
# Found the following SSH public keys:
# 1) id_rsa.pub
# 2) impero_deis_rsa.pub
# ...
# Which would you like to use with Deis? 2
# Uploading /Users/myuser/.ssh/impero_deis_rsa.pub to Deis... done
```

#### Logout from a controller
```sh
$ deis logout
Logged out as impero
```

#### Configure the DNS
Please read [this](http://docs.deis.io/en/latest/managing_deis/configure-dns/#configure-dns).

#### Configure the Load Balancer
please read [this](http://docs.deis.io/en/latest/managing_deis/configure-load-balancers/).
