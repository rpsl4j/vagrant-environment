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
    ensure => "absent",
    provider => "rpm",
    source => "http://service.bgroberts.id.au/bird-1.4.5-1.el6.x86_64.rpm",
    notify => Package["quagga"]
}

file { "/etc/bird.conf":
    mode => 0644,
    owner => "root",
    group => "root",
    source => "puppet:///modules/abn3500/bird.conf"
}

package { "quagga":
    ensure => "installed",
    notify => [File["/etc/quagga/bgpd.conf"], File["/etc/sysconfig/quagga"]]
}

file { "/etc/quagga/bgpd.conf":
    mode => 0644,
    owner => "root",
    group => "root",
    source => "puppet:///modules/abn3500/bgpd.conf",
    notify => Service["bgpd"]
}

file { "/etc/sysconfig/quagga":
    mode => 0644,
    owner => "root",
    group => "root",
    source => "puppet:///modules/abn3500/sysconfig-quagga",
    notify => Service["bgpd"]
}

service { "bgpd":
    name => "bgpd",
    ensure => "running",
    enable => "true"
}

package { "opendaylight":
    ensure => "installed",
    provider => "rpm",
    source => "http://service.bgroberts.id.au/opendaylight-0.3.0-0.noarch.rpm",
    require => Package["openjdk-7"]
}

package { "epel-release":
    ensure => "installed",
    provider => "rpm",
    source => "https://mirror.aarnet.edu.au/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm"
}

package { "tmux":
    ensure => "installed",
    require => Package["epel-release"]
}

package { "telnet":
    ensure => "present"
}

file { "/home/vagrant/start-tmux.sh":
    mode => 755,
    owner => "vagrant",
    group => "vagrant",
    source => "puppet:///modules/abn3500/start-tmux.sh"
}

package { "readline":
    ensure => "present",
}

package { "irrtoolset":
    ensure => "installed",
    provider => "rpm",
    source => "http://service.bgroberts.id.au/irrtoolset-a86c5f59bd15280dde0114bb6523ce96563da075-1.el6.x86_64.rpm",
    require => Package["readline"],
}

package { "rpm-build":
    ensure => "installed"
}

package { "rpmdevtools":
    ensure => "installed"
}

package { "java-1.7.0-openjdk-devel":
    ensure => "installed"
}
