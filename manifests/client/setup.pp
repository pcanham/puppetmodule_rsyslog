# Class: rsyslog::client::setup
#
# This class installs rsyslog
#
# Parameters:
#  [*syslogserver*]   - Syslog FQDN for the client
#  [*enable_tcp*]     - Boolean determining whether you want to
#                       have TCP communication enabled.
#  [*tcp_port*]       - TCP port used by the client
#  [*enable_udp*]     - Boolean determining whether you want to
#                       have UDP communication enabled.
#  [*udp_port*]       - UDP port used by the client
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::client::setup':
#   syslogserver => 'syslog.example.internal',
#   tcp_enable   => true,
#   tcp_port     => '514',
#   udp_enable   => false
# }
class rsyslog::client::setup(
  $rsyslogmjrver = $rsyslog::rsyslogmjrver,
  $syslogserver  = undef,
  $tcp_enable    = $rsyslog::tcp_enabled,
  $tcp_port      = $rsyslog::tcp_port,
  $udp_enable    = $rsyslog::udp_enabled,
  $udp_port      = $rsyslog::udp_port
) {

  if defined(Class['rsyslog::yumrepo']) {
    notice("Class: rsyslog::yumrepo already defined.")
  } else {
    class {'rsyslog::yumrepo':
              before => Class['rsyslog::install'],
    }
  }

  class { 'rsyslog::install': }->
    file { "${rsyslog::syslog_config}":
        ensure   => file,
        backup   => true,
        owner    => 'root',
        group    => 'root',
        mode     => '0750',
        checksum => md5,
        content  => template("rsyslog/${rsyslog::rsyslogmjrver}-rsyslog.conf.erb"),
      }~>
        class { 'rsyslog::service': }
}