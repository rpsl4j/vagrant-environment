# Repos
wget::fetch { "maven-repo":
    source => "https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo",
    destination => "/etc/yum.repos.d/apache-maven.repo"
} -> file { "/etc/yum.repos.d/apache-maven.repo":
    ensure => "present",
    owner => "root",
    group => "root",
    mode => 0644
}

# Required packages
package { "openjdk-7":
    name => "java-1.7.0-openjdk-devel.x86_64",
    ensure => "present"
}

package { "apache-maven":
    name => "apache-maven",
    ensure => "present",
    require => File["/etc/yum.repos.d/apache-maven.repo"]
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
} ~> exec { "controller-packages":
    command => "/usr/bin/mvn clean",
    cwd => "/open-daylight/controller",
    user => "vagrant",
    require => [File["/home/vagrant/.m2/settings.xml"], Package["apache-maven"]],
    refreshonly => true,
    timeout => 0
}
