define syslog_ng::template (
  $params = [],
  $order = '20'
) {
  $type = 'template'
  $id = $title

  concat::fragment { "syslog_ng::template ${title}":
    target  => $::syslog_ng::config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
