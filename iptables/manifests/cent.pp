class iptables::cent{

  exec { 'clear-firewall':
    command     => '/sbin/iptables -F',
    refreshonly => true,
  }

  exec { 'persist-firewall':
    command     => '/sbin/service iptables save',
    #refreshonly => true,
	}

	Firewall {
    subscribe => Exec['clear-firewall'],
    notify    => Exec['persist-firewall'],
	}

}
