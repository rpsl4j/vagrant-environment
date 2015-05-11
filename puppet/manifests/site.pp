# Required packages
package { "openjdk-7":
    name => "java-1.7.0-openjdk-devel.x86_64",
    ensure => "present"
}

class { "maven::maven":

}

# Get maven packages
file { "/home/vagrant/.m2":
    ensure => "directory",
    owner => "vagrant",
    group => "vagrant",
    mode => 755
} -> wget::fetch { "opendaylight-maven-settings":
    source => "https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml",
    destination => "/home/vagrant/.m2/settings.xml",
    nocheckcertificate => true
} -> file { "/home/vagrant/.m2/settings.xml":
    ensure => "present",
    owner => "vagrant",
    group => "vagrant",
    mode => 0644
}

package { "bird":
    ensure => "installed",
    provider => "rpm",
    source => "http://service.bgroberts.id.au/bird-1.4.5-1.el6.x86_64.rpm",
    notify => File["/etc/bird.conf"]
}

file { "/etc/bird.conf":
    mode => 0644,
    owner => "root",
    group => "root",
    source => "puppet:///modules/abn3500/bird.conf"
}
