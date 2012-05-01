class redis(
$repo="deb http://backports.debian.org/debian-backports squeeze-backports main"
){

  exec { "backports-repo":
    path    => "/bin:/usr/bin",
    command => "echo '$repo' >> /etc/apt/sources.list",
    unless  => "cat /etc/apt/sources.list | grep squeeze-backports",
  }

  exec { "apt-update":
    path    => "/bin:/usr/bin",
    command => "apt-get update",
    unless  => "ls /usr/bin | grep redis-server",
    require => Exec["backports-repo"],
  }

  package { "redis-server":
    ensure  => '2:2.4.2-1~bpo60+1',
    require => Exec["apt-update"],
  }

  service { "redis-server":
    enable  => true,
    ensure  => running,
    require => Package["redis-server"],
  }

}
