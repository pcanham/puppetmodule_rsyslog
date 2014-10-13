node default {
  Yumrepo <| |> -> Package <| |>
  class { 'rsyslog':
    rsyslogmjrver => 8,
    enabled       => true,
    syslogserver  => 'syslog.sandbox.internal',
    client        => true,
    tcp_port      => "514",
    tcp_enable    => true
  }
}
