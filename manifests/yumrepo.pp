# Class: rsyslog::yumrepo
#
# This class setups the yum repos needed for downloading rsyslog
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::yumrepo': }
#
#
class rsyslog::yumrepo {
  yumrepo { 'rsyslog-v5-stable':
    baseurl => "http://rpms.adiscon.com/v5-stable/epel-6/${::architecture}",
    descr => "Adiscon Rsyslog v5-stable for CentOS-6-${::architecture}",
    gpgkey => 'http://rpms.adiscon.com/RPM-GPG-KEY-Adiscon',
    enabled => '0',
    gpgcheck => '0',
  }

  yumrepo { 'rsyslog-v6-stable':
    baseurl => "http://rpms.adiscon.com/v6-stable/epel-6/${::architecture}",
    descr => "Adiscon Rsyslog v6-stable for CentOS-6-${::architecture}",
    gpgkey => 'http://rpms.adiscon.com/RPM-GPG-KEY-Adiscon',
    enabled => '1',
    gpgcheck => '0',
  }

  yumrepo { 'rsyslog-v7-stable':
    baseurl => "http://rpms.adiscon.com/v7-stable/epel-6/${::architecture}",
    descr => "Adiscon Rsyslog v7-stable for CentOS-6-${::architecture}",
    gpgkey => 'http://rpms.adiscon.com/RPM-GPG-KEY-Adiscon',
    enabled => '0',
    gpgcheck => '0',
  }
}