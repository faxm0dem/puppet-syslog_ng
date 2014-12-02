class syslog_ng::reload (
  $syntax_check_before_reloads = true
) {

  include syslog_ng::params

  $config_file     = $::syslog_ng::config_file
  $tmp_config_file = $::syslog_ng::params::tmp_config_file


  $syslog_ng_ctl_full_path = "${::syslog_ng::sbin_path}/syslog-ng-ctl"
  $syslog_ng_full_path = "${::syslog_ng::sbin_path}/syslog-ng"

  # echo always returns 0
  $check_syntax_command = $syntax_check_before_reloads ? {
    true  => "${syslog_ng_full_path} --syntax-only --cfgfile ${tmp_config_file}",
    false => 'echo'
  }

  notice("syslog_ng::reload: syntax_check_before_reloads=${syntax_check_before_reloads}")
  notice("syslog_ng::reload: check_syntax_command=${check_syntax_command}")

  exec { 'reload':
    command     => "${syslog_ng_ctl_full_path} reload",
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:',
    refreshonly => true,
    try_sleep   => 1,
    require     => Package[$::syslog_ng::params::package_name],
    logoutput   => true,
    onlyif      => $check_syntax_command,
    refresh     => "cp ${tmp_config_file} ${config_file}"
  }
}
