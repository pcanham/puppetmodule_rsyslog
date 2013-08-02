# Define: rsyslog::client::imfile::httpd-error
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
#  rsyslog::client::imfile::httpd-error { "httpd-error-${::hostname}":
#    logfilename => '/var/log/httpd/error_log',
#  }
#
define rsyslog::client::imfile::httpd-error(
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
