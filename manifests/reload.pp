#
class syslog_ng::reload {

  $syslog_ng_ctl_full_path = "${syslog_ng::sbin_path}/syslog-ng-ctl"

  exec { 'syslog_ng_reload':
    command     => "${syslog_ng_ctl_full_path} reload",
    logoutput   => 'on_failure',
    refreshonly => true,
    try_sleep   => 1
  }
}
