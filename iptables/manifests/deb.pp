class iptables::deb{
	
  exec { 'clear-firewall':
    command     => '/sbin/iptables -F',
    refreshonly => true,
  }

  exec { 'persist-firewall':
    command => '/sbin/iptables-save >/etc/iptables.up.rules',
    refreshonly => true,
  }

  Firewall {
    subscribe => Exec['clear-firewall'],
    notify    => Exec['persist-firewall'],
  }

  file {'/etc/network/if-pre-up.d/iptables':
    source => 'puppet:///modules/iptables/iptables',
    owner  => 'root',
    group  => 'root',
    mode   => '755',
  }

}
