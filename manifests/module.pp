#
define syslog_ng::module {
  $module_prefix = $::syslog_ng::module_prefix
  package { "${module_prefix}${title}":
    ensure => present
  }
}
