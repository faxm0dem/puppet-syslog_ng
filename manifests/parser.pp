define syslog_ng::parser (
  $params = [],
  $order = '40'
) {
  $type = 'parser'
  $id = $title

  concat::fragment { "syslog_ng::parser ${title}":
    target  => $::syslog_ng::config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
