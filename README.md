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

# compile open-daylight 
cd /open-daylight
./build.sh

# run open-daylight
cd /open-daylight/integration/distributions/karaf/target/assembly
bin/karaf
```
# Bird and ODL BGP
bird is installed during the provisioning phase and is configured using `puppet/modules/abncomp3500/files/bird.conf`.

The VM has 2 private network interfaces for Bird and ODL. Bird binds to 172.31.0.1 (AS1) and assumes ODL will bind to 172.31.1.1 (AS2).

Interact with bird using `service bird start/stop/restart/status` and the birdc command (from root or using sudo). Logs can be followed using `tail -f /var/log/messages | grep bird`.
