class iptables{

  case $operatingsystem {
    centos: {include iptables::cent}
    debian: {include iptables::deb}
  }	

  resources { 'firewall':
    purge => true,
	}
       
  firewall {'000 allow packets with valid state':
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

  firewall {'001 allow ssh':
    proto  => 'tcp',
    dport  => '22',
    action => 'accept',
  }

  firewall {'002 allow http':
    proto  => 'tcp',
    dport  => '80',
    action => 'accept',
  }

  firewall {'003 allow https':
    proto  => 'tcp',
    dport  => '443',
    action => 'accept',
  }

  firewall {'004 allow localhost':
    iniface => 'lo',
    action  => 'accept',
  }

  firewall { "999 drop all other requests":
    action => "drop",
  }

}
