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
  
  if defined(Package['redhat-lsb']) {
    notice("Package: redhat-lsb already defined.")
  } else {
    package {'redhat-lsb':
      before => Yumrepo["rsyslog-v${rsyslog::rsyslogmjrver}-stable"]
    }
  }
 
  yumrepo { "rsyslog-v${rsyslog::rsyslogmjrver}-stable":
    baseurl => $rsyslog::yum_baseurl,
    descr => $rsyslog::yum_descr,
    gpgkey => $rsyslog::yum_gpgkey,
    enabled => '1',
    gpgcheck => '0',
    require => Package['redhat-lsb']
  }
}
