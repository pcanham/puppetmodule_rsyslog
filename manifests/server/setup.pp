# Class: rsyslog::server::setup
#
# This class installs rsyslog
#
# Parameters:
#  [*enable_tcp*]   - Boolean determining whether you want to
#                     have TCP communication enabled.
#  [*tcp_port*]     - TCP port used by the server/client
#  [*enable_udp*]   - Boolean determining whether you want to
#                     have UDP communication enabled.
#  [*udp_port*]     - UDP port used by the server
#  [*logpath*]      - Location where you wish to store remote server log files. 
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#   class { 'rsyslog::server::setup':
#      tcp_enable  => true,
#      tcp_port    => '514',
#      udp_enable  => false
#    }
class rsyslog::server::setup(
  $rsyslogmjrver  = ${rsyslog::rsyslogmjrver},
  $tcp_enable     = $rsyslog::tcp_enabled,
  $tcp_port       = $rsyslog::tcp_port,
  $udp_enable     = $rsyslog::udp_enabled,
  $udp_port       = $rsyslog::udp_port,
  $logpath        = $rsyslog::logpath
) {
  require rsyslog::params

  if defined(Class['rsyslog::yumrepo']) {
    notice("Class: rsyslog::yumrepo already defined.")
  } else {
    class {'rsyslog::yumrepo':
              before => [ Class['rsyslog::install'], 
                          Class['rsyslog::service'],
                          File["${rsyslog::syslog_config}"],
               ],
    }
  }

  class { 'rsyslog::install': }
  class { 'rsyslog::service': }
  
  file { "${rsyslog::syslog_config}":
    ensure   => file,
    backup   => true,
    owner    => 'root',
    group    => 'root',
    mode     => '0750',
    checksum => md5,
    content  => template("rsyslog/${rsyslogmjrver}-rsyslog.conf.erb"),
    require  => Class['rsyslog::install'],
    notify   => Class['rsyslog::service']
  }
}
