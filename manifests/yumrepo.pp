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
      before => Package['redhat-lsb'] 
    }
  }
  
  yumrepo { "rsyslog-v${rsyslog::rsyslogmjrver}-stable":
    baseurl => "http://rpms.adiscon.com/v${rsyslog::rsyslogmjrver}-stable/epel-${::lsbmajdistrelease}/${::architecture}",
    descr => "Adiscon Rsyslog v${rsyslog::rsyslogmjrver}-stable for CentOS-${::lsbmajdistrelease}-${::architecture}",
    gpgkey => 'http://rpms.adiscon.com/RPM-GPG-KEY-Adiscon',
    enabled => '1',
    gpgcheck => '0',
    require => Package['redhat-lsb']
  }
}
