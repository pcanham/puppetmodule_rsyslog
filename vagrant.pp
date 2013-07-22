node default {
  class { 'rsyslog':
    enabled      => true,
    server       => true,
    tcp_port     => "514",
    tcp_enable   => true
  }
}