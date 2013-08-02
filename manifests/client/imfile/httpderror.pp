# Define: rsyslog::client::imfile::httpderror
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
#  rsyslog::client::imfile::httpderror { "httpd-error-${::hostname}":
#    logfilename => '/var/log/httpd/error_log',
#  }
#
define rsyslog::client::imfile::httpderror(
  $logfilename = undef,
  ) {

  if $logfilename == undef { fail('logfilename not set.') }

  rsyslog::client::imfile { $name:
    logfilename => $logfilename,
    filetag     => 'httpd_error_log',
    statefile   => 'httpd_error_log_state',
    severity    => 'notice',
    factility   => 'local3',
  }
}
