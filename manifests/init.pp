# Copyright 2014 Tibor Benke

class syslog_ng (
  $config_file          = $::syslog_ng::params::config_file,
  $package_name         = $::syslog_ng::params::package_name,
  $service_name         = $::syslog_ng::params::service_name,
  $module_prefix        = $::syslog_ng::params::module_prefix,
  $init_config_file     = $::syslog_ng::params::init_config_file,
  $init_config_hash     = {},
  $manage_init_defaults = false,
  $manage_package       = true,
  $modules              = [],
  $sbin_path            = '/usr/sbin',
  $user                 = 'root',
  $group                = 'root',
  $syntax_check_before_reloads = true,
  $config_file_header   = $::syslog_ng::params::config_file_header,
) inherits syslog_ng::params {

  validate_bool($syntax_check_before_reloads)
  validate_bool($manage_package)
  validate_bool($manage_init_defaults)
  validate_array($modules)
  validate_hash($init_config_hash)

  if ($manage_package) {
    package { $::syslog_ng::params::package_name:
      ensure => present,
      before => [
        Concat[$config_file],
        Exec[syslog_ng_reload]
      ]
    }
    syslog_ng::module {$modules:}
  }

  @concat { $config_file:
    ensure => present,
    path   => $config_file,
    owner  => $user,
    group  => $group,
    warn   => true,
    ensure_newline => true,
  }
  
  class {'syslog_ng::reload':
    syntax_check_before_reloads => $syntax_check_before_reloads
  }
  

  notice("config_file: ${config_file}")

  concat::fragment {'syslog_ng header':
    target => $config_file,
    content => $config_file_header,
    order => '01'
  }

  if $manage_init_defaults {
    $merged_init_config_hash = merge($init_config_hash,$::syslog_ng::params::init_config_hash)
    file {$init_config_file:
      ensure  => present,
      content => template('syslog_ng/init_config_file.erb'),
      notify => Exec[syslog_ng_reload]
    }
  }

  service { $::syslog_ng::params::service_name:
    ensure  =>  running,
    enable  =>  true,
    require =>  Concat[$config_file]
  }
}
