define syslog_ng::config (
  $content = '',
  $order = '5'
) {
  concat::fragment { "syslog_ng::config ${title}":
    target  => $::syslog_ng::tmp_config_file,
    content => "${content}\n",
    order => $order
  }
}
