# Copyright 2014 Tibor Benke

class syslog_ng (
  $config_file          = $::syslog_ng::params::config_file,
  $sbin_path            = '/usr/sbin',
  $purge_syslog_ng_conf = false,
  $user                 = 'root',
  $group                = 'root',
  $options              = $::syslog_ng::params::options
) inherits syslog_ng::params {

  validate_bool($purge_syslog_ng_conf)

  include syslog_ng::reload

  package { "$syslog_ng::params::package_name":
    ensure => present
  }

  concat { $::syslog_ng::params::config_file:
    ensure => present
  }
 
  file { $config_file:
    ensure  => present,
    path    => $config_file,
    owner   => $user,
    group   => $group,
    notify  => Exec['syslog_ng_reload'],
    require => Package[$syslog_ng::params::package_name]
  }

  service { "$syslog_ng::params::service_name":
    ensure  =>  running,
    require =>  File[$config_file]
  }
}
