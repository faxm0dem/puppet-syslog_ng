define syslog_ng::rewrite (
  $params = [],
  $order = '30'
) {
  $type = 'rewrite'
  $id = $title

  concat::fragment { "syslog_ng::rewrite ${title}":
    target  => $::syslog_ng::config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
