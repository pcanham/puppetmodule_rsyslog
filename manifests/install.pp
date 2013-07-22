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
  package { "$rsyslog::packagename":
    ensure => latest,
  }

  $extsyslog_dir = $rsyslog::extsyslog_dir
  file { $extsyslog_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750'
  }
}
