# opendaylight-dev-environment
## requirements
 + [vagrant](https://www.vagrantup.com/downloads.html)
 + [virtualbox](https://www.virtualbox.org/wiki/Downloads)

## quickstart
```
vagrant up
vagrant ssh
./start-tmux.sh
```

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

The VM has 2 private network interfaces for Bird and ODL. Bird binds to 172.31.0.R2(AS1) and assumes ODL will bind to 172.31.1.2 (AS2).

Interact with bird using `service bird start/stop/restart/status` and the birdc command (from root or using sudo). Logs can be followed using `tail -f /var/log/messages | grep bird`.

# Pre-installed ODL
A copy of ODL Helium from the CloudRouter project is installed during provision and can be found at `/opt/opendaylight/opendaylight-helium`.

To bring up the karaf-console and enable the BGP module:

    1. execute `sudo /opt/opendaylight/opendaylight-helium/bin/karaf`
    2. install the BGP feature in karaf: `feature:install odl-bgpcep-bgp-all` (see all features with `feature:list`)
    3. install RESTConf: `feature:install odl-restconf-all` (will run on 8181, should be forwarded to host)
    4. Disable authentication (so we can use restconf etc):
        1. `config:edit org.opendaylight.aaa.authn`
        2. `config:property-set authEnabled false`
        3. `config:update`
    4. edit the BGP configuration file as required (check `feature:info odl-bgpcep-bgp-all`
    5. Exit (Ctrl+D) and repoen karaf for changes to take effect (`sudo netstat -pnl | grep BGP-PORT` should show java listening on the BGP port)


