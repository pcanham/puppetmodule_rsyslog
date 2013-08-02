# Define: rsyslog::client::imfile::httpd-access
#
# This module manages custom files being pushed through rsyslog via
# imfile module.
#
# Parameters:
#  [*logfilename*]  - full path of file you wish to monitor in rsyslog
#  [*desc*]      -
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  rsyslog::client::imfile::httpd-access { "httpd-access-${::hostname}":
#    logfilename => '/var/log/httpd/access_log',
#  }
#
define rsyslog::client::imfile::httpd-access(
  $logfilename = undef,
  ) {

  if $logfilename == undef { fail('logfilename not set.') }

  rsyslog::client::imfile { $name:
    logfilename => $logfilename,
    filetag     => 'httpd_access_log',
    statefile   => 'httpd_access_log_state',
    severity    => 'notice',
    factility   => 'local3',
  }
}
