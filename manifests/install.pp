# Class: rsyslog::install
#
# This class installs rsyslog package
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::install': }
#
class rsyslog::install {
  
  exec { 'rsyslog-yum-clean-expire-cache': 
    path     => '/bin:/usr/bin:/usr/sbin:/usr/local/bin',
    require  => Yumrepo["rsyslog-v${rsyslog::rsyslogmjrver}-stable"],
    command  => "yum clean expire-cache",
    before   => Package["$rsyslog::packagename"],
  }

  package { $rsyslog::packagename:
    ensure  => latest,
    require => [ Exec['rsyslog-yum-clean-expire-cache'],
                  Yumrepo["rsyslog-v${rsyslog::rsyslogmjrver}-stable"]
               ],
    notify  => Class[rsyslog::service],
  }

  file { $rsyslog::extsyslog_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    require => Package["$rsyslog::packagename"]
  }
}
