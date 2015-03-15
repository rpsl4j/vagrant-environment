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
