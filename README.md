# opendaylight-dev-environment
## requirements
 + [vagrant](https://www.vagrantup.com/downloads.html)
 + [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## usage
```
# clone the repo, git/ssh runs on port 2222
git clone git@gitlab.cecs.anu.edu.au:abn-comp3100/vagrant-repo.git
cd vagrant-repo

# download the opendaylight controller repo
git submodule init
git submodule update

# bring up the dev environment
vagrant up

# shell into your new development box!
vagrant ssh

# compile controller
cd /open-daylight
./build.sh
```
