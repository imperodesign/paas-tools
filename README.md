This repo contains everything you need to:
- set up Impero PaaS infrastructure from scratch
- update Impero PaaS infrastructure
- create, deploy, and destroy an application

Impero [PaaS](https://en.wikipedia.org/wiki/Platform_as_a_service) infrastructure is built on top of [Deis](http://deis.io/). Read more about [Deis components](http://docs.deis.io/en/latest/understanding_deis/components/)

## Repository Organisation

### bin
This folder contains `deis` and `deisctl` binary app. `deis` is a “dev” tool, used to deploy and scale applications to a Deis platform. `deisctl` is an “ops” tool, used to configure and manage the Deis platform itself.

### deis
This folder contain the infrastructure provisioning files, both for staging and production clusters.


## References
- [Deis]() - Open source PaaS that makes it easy to deploy and manage applications on your own servers
- [CoreOS]() - Minimal operating system that supports popular container systems out of the box
- [fleet]() - A scheduling backend included with CoreOS
- [PostgreSQL](http://www.postgresql.org/)
