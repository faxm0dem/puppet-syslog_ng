# Copyright 2014 Tibor Benke

class syslog_ng (
  $config_file          = '/etc/syslog-ng/syslog-ng.conf',
  $sbin_path            = '/usr/sbin',
  $purge_syslog_ng_conf = false,
  $options              = $::syslog_ng::params::options
) inherits syslog_ng::params {

  validate_bool($purge_syslog_ng_conf)

  #include syslog_ng::reload

  $user = 'tibi'
  $group = 'btibi'

  $syslog_ng_conf_content = template('syslog_ng/syslog-ng.conf.erb')

  file { $config_file:
    ensure  => present,
    path    => $config_file,
    owner    => $user,
    group   => $group,
    content => $syslog_ng_conf_content,
    notify  => Exec['syslog_ng_reload']
  }
}
