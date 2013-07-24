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
  
  exec { 'rsyslog-yum-clean-all': 
    path      => '/bin:/usr/bin:/usr/sbin:/usr/local/bin',
    subscribe => [ Yumrepo['rsyslog-v5-stable'], Yumrepo['rsyslog-v6-stable'], Yumrepo['rsyslog-v7-stable'] ], 
    command   => "yum clean all",
    before    => Package["$rsyslog::packagename"],
  }

  package { $rsyslog::packagename:
    ensure  => latest,
    require => Exec['rsyslog-yum-clean-all'],
  }

  file { $rsyslog::extsyslog_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750'
  }
}
