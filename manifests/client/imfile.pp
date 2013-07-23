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
  $severity          = 'debug',
  $factility         = 'local3',
) {

  if $logfilename == undef { fail('logfilename not set.') }
  if $filetag == undef { fail('filetag not set.') }
  if $statefile == undef { fail('statefile not set.') }
  
  

  $imfilecontent = $rsyslogmjrver ? {
                      6       => '$ModLoad imfile',
                      7       => 'module(load="imfile" PollingInterval="10")',
                      default => '$ModLoad imfile'
                    },

  if defined(File["${rsyslog::extsyslog_dir}/imfile.conf"]) {
      notice("File: ${rsyslog::extsyslog_dir}/imfile.conf already defined.")
    } else {
      file { "${rsyslog::extsyslog_dir}/imfile.conf":
       content => $imfilecontent,
       backup  => false,
       notify  => Class['rsyslog::service'],
      }    
    }

  file { "${rsyslog::extsyslog_dir}/${filetag}":
    ensure  => file,
    path    => "${rsyslog::extsyslog_dir}/${filetag}.conf",
    backup  => false,
    content => template("rsyslog/${rsyslogmjrver}-imfile.conf.erb"),
    require => Class['rsyslog::install'],
    notify  => Class['rsyslog::service'],
  }
}
