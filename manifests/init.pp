# Copyright 2014 Tibor Benke

class syslog_ng (
  $config_file = '/etc/syslog-ng/syslog-ng.conf',
  $sbin_path = '/usr/sbin',
  $purge_syslog_ng_conf = true
  ) {

  include syslog_ng::reload

  $user = 'tibi'
  $group = 'btibi'

  $syslog_ng_conf_content = $purge_syslog_ng_conf ? {
    false => undef,
    true  => 'Syslog-ng configuration is managed by Puppet',
  }


  file { $config_file:
    ensure  => present,
    path    => $config_file,
    user    => $user,
    group   => $group,
    content => $syslog_ng_conf_content,
    notify  => Exec['syslog_ng_reload']
  }
}
