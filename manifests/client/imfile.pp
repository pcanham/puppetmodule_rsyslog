# Define: rsyslog::client::imfile
#
# This module manages custom files being pushed through rsyslog via
# imfile module.
#
# Parameters:
#  [*logfilename*]  - full path of file you wish to monitor in rsyslog
#  [*filetag*]      -
#  [*statefile*]    -
#  [*severity*]     -
#  [*factility*]    -
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
#  rsyslog::client::imfile { 'mcollective_imfile':
#    logfilename => '/var/log/mcollective.log',
#    filetag     => 'mcollective',
#    statefile   => 'mcollective_state'
#  }
#
define rsyslog::client::imfile(
  $rsyslogmjrver     = "${rsyslog::rsyslogmjrver}",
  $logfilename       = undef,
  $filetag           = undef,
  $statefile         = undef,
  $severity          = 'notice',
  $factility         = 'local3',
) {

  if $logfilename == undef { fail('logfilename not set.') }
  if $filetag == undef { fail('filetag not set.') }
  if $statefile == undef { fail('statefile not set.') }

  $imfile="${rsyslog::extsyslog_dir}/imfile.conf"
  if ! defined(Concat[$imfile]) {
    concat { $imfile:
      owner => root,
      group => root,
      mode  => 644
    }
  }

  if ! defined(Concat::Fragment['imfile_header']) {
    concat::fragment{'imfile_header':
      target => $imfile,
      content => template("rsyslog/${rsyslog::rsyslogmjrver}-imfile-master.conf.erb"),
      order   => 01,
    }
  }

  concat::fragment { "rsyslog config ${title}":
    target  => "${rsyslog::extsyslog_dir}/imfile.conf",
    content => template("rsyslog/${rsyslog::rsyslogmjrver}-imfile.conf.erb"),
  }

}
