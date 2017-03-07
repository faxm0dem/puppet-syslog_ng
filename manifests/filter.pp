define syslog_ng::filter (
  $params = [],
  $order = '50'
) {
  $type = 'filter'
  $id = $title

  concat::fragment { "syslog_ng::filter ${title}":
    target  => $::syslog_ng::config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
