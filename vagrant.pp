node default {
  class { 'rsyslog':
    enabled      => true,
    syslogserver => 'syslog.sandbox.internal',
    client       => true,
    tcp_port     => "514",
    tcp_enable   => true
  }
}
