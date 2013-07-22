# Class: rsyslog::service
#
# This class enforces running of the rsyslog service.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
# class { 'rsyslog::service': }
#
#
class rsyslog::service {
  service { "${rsyslog::svc_name}":
    ensure  => running,
    enable  => true,
  }
}