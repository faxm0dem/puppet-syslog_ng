# Copyright 2014 Tibor Benke

class syslog_ng (
  $config_file          = $::syslog_ng::params::config_file,
  $tmp_config_file      = $::syslog_ng::params::tmp_config_file,
  $package_name         = $::syslog_ng::params::package_name,
  $service_name         = $::syslog_ng::params::service_name,
  $sbin_path            = '/usr/sbin',
  $user                 = 'root',
  $group                = 'root',
  $syntax_check_before_reloads = true,
  $config_file_header   = $::syslog_ng::params::config_file_header,
) inherits syslog_ng::params {

  case $::osfamily {
    Debian: {
    }
    # for RedHat support
    #redhat,centos,fedora,Scientific: {
    #}
    'Redhat', 'Amazon': {
    }
    default: {
      fail("${::hostname}: This module does not support operatingsystem ${::operatingsystem}")
    }
  }

  validate_bool($syntax_check_before_reloads)

  class {'syslog_ng::reload':
    syntax_check_before_reloads => $syntax_check_before_reloads
  }

  package { "$syslog_ng::params::package_name":
    ensure => present
  }

  concat { $tmp_config_file:
    ensure => present,
    path   => $tmp_config_file,
    owner  => $user,
    group  => $group,
    warn   => true,
    ensure_newline => true,
    notify =>  Exec['reload'],
    require => Package[$syslog_ng::params::package_name]
  }

  notice("tmp_config_file: ${tmp_config_file}")

  concat::fragment {'header':
    target => $tmp_config_file,
    content => config_file_header,
    order => '01'
  }
 
  file {$config_file:
    ensure => present,
    path   => $config_file,
    require => Concat["$tmp_config_file"]
  }

  service { "$syslog_ng::params::service_name":
    ensure  =>  running,
    require =>  File[$config_file]
  }
}
