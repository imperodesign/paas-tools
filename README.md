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
