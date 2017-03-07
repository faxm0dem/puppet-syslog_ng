define syslog_ng::source (
  $params = [],
  $order = '60'
) {
  include syslog_ng::params

  $type = 'source'
  $id = $title

  concat::fragment { "syslog_ng::source ${title}":
    target  => $::syslog_ng::config_file,
      content => generate_statement($id, $type, $params),
      order => $order
  }
}
