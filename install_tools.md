## Install Deis tools

### Clone the repo
```sh
$ git clone https://github.com/imperodesign/paas-tools.git ~/.paas-tools
```

### Install the binaries
```
$ cd ~/.paas-tools/bin

# Install deisctl
$ curl -sSL http://deis.io/deisctl/install.sh | sh -s 1.12.2
$ sudo ln -fs $PWD/deisctl /usr/local/bin/deisctl

# Install deis
$ curl -sSL http://deis.io/deis-cli/install.sh | sh
$ ln -fs $PWD/deis /usr/local/bin/deis
```
