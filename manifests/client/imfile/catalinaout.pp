# Define: rsyslog::client::imfile::catalinaout
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
#  rsyslog::client::imfile::catalina-out { "catalina-out-${::hostname}":
#    logfilename => '/app/tomcat/log/catalina.out',
#  }
#
define rsyslog::client::imfile::catalinaout(
  $logfilename = undef,
  ) {

  if $logfilename == undef { fail('logfilename not set.') }

  rsyslog::client::imfile { $name:
    logfilename => $logfilename,
    filetag     => 'catalina_out',
    statefile   => 'catalina_out_state',
    severity    => 'notice',
    factility   => 'local3',
  }
}
