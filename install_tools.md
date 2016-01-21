## Install the Tools

### Clone the repo
```sh
$ git clone https://github.com/imperodesign/paas-tools.git ~/.paas-tools
```

### Install the binaries
```
cd ~/.paas-tools/installers

$ sh install_deisctl.sh -s 1.12.2
$ sudo ln -fs $PWD/deisctl /usr/local/bin/deisctl

$ sh install_deis.sh
$ ln -fs $PWD/deis /usr/local/bin/deis
```

You ready
