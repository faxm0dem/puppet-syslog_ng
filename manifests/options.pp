define syslog_ng::options (
  $options = {}
) {
  $order = '10'

  concat::fragment { $title:
    target  => $::syslog_ng::tmp_config_file,
    content => generate_options($options),
    order => $order
  }
}
