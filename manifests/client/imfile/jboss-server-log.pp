# Define: rsyslog::client::imfile::jboss-server-log
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
#  rsyslog::client::imfile::jboss-server-log { "jboss-server-log-${::hostname}":
#    logfilename => '/app/jboss-5.1.0-GA/server/default/log/server.log',
#  }
#
define rsyslog::client::imfile::jboss-server-log(
  $logfilename = undef,
  ) {

  if $logfilename == undef { fail('logfilename not set.') }

  rsyslog::client::imfile { $name:
    logfilename => $logfilename,
    filetag     => 'jboss_server_log',
    statefile   => 'jboss_server_log_state',
    severity    => 'notice',
    factility   => 'local3',
  }
}
