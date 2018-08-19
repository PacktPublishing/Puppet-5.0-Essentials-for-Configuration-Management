node 'node1.packt.com'{
  user{'basit.alvi':
    ensure => 'present',
    comment => 'This is a corporate account',
    home => '/home/basit',
    shell => '/bin/bash',
    uid => '1001',
  }
  file {'/tmp/sshd_config':
    ensure => 'present',
    source => '/etc/ssh/sshd_config',
  }
  file_line {'tcp-forwarding':
    path => '/tmp/sshd_config',
    line => 'AllowTcpForwarding yes',
    require => File['/tmp/sshd_config'],
  }
  package {'httpd':
    ensure => 'installed',
  }
  service {'httpd':
    ensure => 'running',
    enable => true,
    require => Package['httpd'],
  }
}
