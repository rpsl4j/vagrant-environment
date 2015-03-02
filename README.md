# opendaylight-dev-environment
## requirements
 + [vagrant](https://www.vagrantup.com/downloads.html)
 + [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## usage
```
# clone the repo, git/ssh runs on port 2222
git clone ssh://git@gitlab.bgroberts.id.au:2222/benjamin/opendaylight-dev-environment.git
cd opendaylight-dev-environment

# download the opendaylight controller repo
git submodule init
git submodule update

# bring up the dev environment
vagrant up

# wait like 10 minutes for the maven packages to pull

# shell into your new development box!
vagrant ssh

# compile controller
cd /open-daylight/controller
maven install
```
