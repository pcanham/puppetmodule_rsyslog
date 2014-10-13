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
  
  package { $rsyslog::packagename:
    ensure  => latest,
    require => Yumrepo["rsyslog-v${rsyslog::rsyslogmjrver}-stable"],
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
