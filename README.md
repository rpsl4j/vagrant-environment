# rpsl4j-vagrant-environment
A virtualised environment for packaging rpsl4j and testing/developing against OpenDaylight Lithium and Quagga bgpd.

The environment is built on a VirtualBox backed CentOS 6.6 Vagrant box and is configured using Puppet.

## Requirements
 + [Vagrant](https://www.vagrantup.com/downloads.html)
 + [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


## Quickstart
```bash
vagrant up
vagrant ssh
~/start-tmux.sh
```
This will start up a new `tmux` session running Opendaylight and bgpd. The VM has 2 private network interfaces, one for bgpd and the other for OpenDaylight. bgpd listens on 172.31.0.2 as AS1 and will attempt to connect to OpenDaylight on 172.31.1.2 as AS2.

## Configuring OpenDaylight Lithium
OpenDaylight Lithium  is installed during the provision process and can be started by executing `~/start-tmux.sh` or `sudo /opt/opendaylight/bin/karaf`

To enable the BGP and RESTconf modules:

   1. Start OpenDaylight by starting the karaf console (see above)
   2. Install the BGP feature by executing  `feature:install odl-bgpcep-bgp-all` in the karaf console. _(to view all available features, execute_ `feature:list`_)_
   3. Install the RESTconf feature by executing `feature:install odl-restconf-all`. RESTconf will listen on port 8181 and will be forwarded to the same port on the host by VirtualBox.
   4. __(OPTIONAL)__ Disable authentication for RESTconf by executing the following:
       1. `config:edit org.opendaylight.aaa.authn`
       2. `config:property-set authEnabled false`
       3. `config:update`
   4. Configure the BGP module by editing the required configuration files. These can be enumerated by executing `feature:info odl-bgpcep-bgp-all`.
       * Refer to the _rpsl4j-opendaylight_ documentation for instructions on generating a BGP configuration. A sample RPSL document for the environment is [provided](docs/vagrant.rpsl).
   5. Exit the karaf console (Ctrl+D) and reopen for changes to take effect.
       * You should be able to see RESTconf and the BGP module listening by executing `sudo netstat -pnl | grep "8181\|BGP-PORT"`.

## Quagga bgpd Configuration
bpgd is installed during the provisioning phase and using a [configuration file](puppet/modules/abncomp3500/files/bgpd.conf) installed by Puppet.

The bgpd service can be manipulated using the `service` as follows:
`sudo service bgpd start/stop/restart/status`

Once running you can connect to the command interface (`$ telnet localhost 2605`) using the password: "password":


## Included Software:
 + OpenDaylight Lithium
 + Quagga bgpd
 + irrtoolset
 + rpmbuild and rpmdevtools
 + Maven
 + Java 1.7 JDK
 + tmux

## License
Original content in this repository is licensed under the GNU Affero General Public License.
