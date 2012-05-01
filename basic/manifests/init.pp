class basic {

  user { 'deploy':
    ensure     => present,
    home       => '/home/deploy',
    shell      => '/bin/zsh',
    managehome => true,
  }

  package { ["zsh",
    "ntp",
    "sudo",
    "openssh-server",]:
    ensure => installed,
  }

  service { ntp:
    enable => true,
    ensure => running,
  }

  service { ssh:
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
  }

  file {'/etc/ssh/sshd_config':
    source  => 'puppet:///modules/basic/sshd_config',
    owner   => 'root',
    group   => 'root',
    mode    => '640',
    notify  => Service[ssh],
    require => Package['openssh-server'],
  }
	
  file {"/home/deploy/.ssh":	
    ensure  => directory,
    owner   => 'deploy',
    group   => 'deploy',
    require => User['deploy'],
  }		
        
  file {'/home/deploy/.ssh/authorized_keys':
    source  => 'puppet:///modules/basic/authorized_keys',
    owner   => 'deploy',
    mode    => '600',
    require => File["/home/deploy/.ssh"],
  }

  file {'/etc/sudoers':
    source  => 'puppet:///modules/basic/sudoers',
    owner   => 'root',
    group   => 'root',
    mode    => '440',
    require => Package["sudo"],
  }

}
