# Impero PaaS Tools

> CAUTION: FOR REAL DEV/OPS ONLY!

This repo contains everything you need to:
- set up the Impero PaaS infrastructure from scratch on [AWS](https://aws.amazon.com/)
- update Impero PaaS infrastructure
- create, deploy, and destroy an application

Impero [PaaS](https://en.wikipedia.org/wiki/Platform_as_a_service) infrastructure is built on top of [Deis](http://deis.io/) and [AWS](https://aws.amazon.com/). Read more about [Deis components](http://docs.deis.io/en/latest/understanding_deis/components/).

## Architecture
<img src="http://docs.deis.io/en/latest/_images/DeisSystemDiagram.png" alt="Architecture" />
More details [here](http://docs.deis.io/en/latest/understanding_deis/architecture/).

### Components
Deis consists of a number of components that combine to create a distributed PaaS. Each Deis component is deployed as a container or set of containers. The components are: Controller, Database, Builder, Registry, Logspout, Logger, Publisher, Router, Store.

### Three nodes cluster (impero default) failover

#### Losing One of Three Nodes
Losing one of three nodes will have the following effects:
Ceph will enter a health warn state but will continue to function.
Anything scheduled on the downed node will be rescheduled to the other two nodes. If your remaining nodes don’t have the resources to run the new units, this could take down the entire platform
When you scale up to three nodes again, Ceph and Etcd will still think one member is down. You will need to manually remove the downed node from Ceph and Etcd.

#### Losing Two of Three Nodes
Losing two of three nodes will have the following effects:
Ceph will enter a degraded state and go into read-only mode.
Etcd will enter a degraded state and go into read-only mode.
Anything scheduled on the downed node will be rescheduled to remaining node. If your remaining node doesn’t have the resources to run the new units, this could take down the entire platform.
When you scale up to three nodes again, Ceph and Etcd will still think two members are down. You will need to manually remove the downed nodes from Ceph and Etcd.

## Repository Organisation

### installers
This folder contains `install_deis.sh` and `install_deisctl.sh` to install `deis` and `deisctl` respectively. `deis` is a “dev” tool, used to deploy and scale applications to a Deis platform. `deisctl` is an “ops” tool, used to configure and manage the Deis platform itself.

### deis
This folder contain the infrastructure provisioning files, both for staging and production clusters.

### .deis
This folder contain deis units.

## Readings

### [Bootstrap from scratch the infrastructure on AWS](bootstrap_infrastructure.md)
### Update Impero PaaS infrastructure (coming soon)
### [Create, deploy, and destroy an application](manage_application.md)

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
