class syslog_ng::reload (
  $syntax_check_before_reloads = true
) {

  include ::syslog_ng::params

  $config_file     = $::syslog_ng::config_file
  $tmp_config_file = $::syslog_ng::params::tmp_config_file
  $exec_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:'

  $syslog_ng_ctl_full_path = "${::syslog_ng::sbin_path}/syslog-ng-ctl"
  $syslog_ng_full_path = "${::syslog_ng::sbin_path}/syslog-ng"

  exec { 'syslog_ng_syntax_check':
    command     => "${syslog_ng_full_path} --syntax-only --cfgfile ${tmp_config_file}",
    path        => $exec_path,
    refreshonly => true
  }

  notice("syslog_ng::reload: syntax_check_before_reloads=${syntax_check_before_reloads}")

  exec { 'syslog_ng_reload':
    command     => "${syslog_ng_ctl_full_path} reload",
    path        => $exec_path,
    refreshonly => true,
    try_sleep   => 1,
    logoutput   => true,
  }
  
  exec { 'syslog_ng_deploy_config':
    command     => "cp ${tmp_config_file} ${config_file}",
    path        => $exec_path,
    refreshonly => true
  }

  if $syntax_check_before_reloads {
    File[$tmp_config_file] ~> Exec['syslog_ng_syntax_check'] ~> Exec['syslog_ng_deploy_config'] ~> Exec['syslog_ng_reload']
  } else {
    File[$tmp_config_file] ~>                                   Exec['syslog_ng_deploy_config'] ~> Exec['syslog_ng_reload']
  }
}
