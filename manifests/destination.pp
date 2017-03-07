define syslog_ng::destination (
  $params = [],
  $order = '70'
) {
  $type = 'destination'
  $id = $title

  concat::fragment { "syslog_ng::destination ${title}":
    target  => $::syslog_ng::config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
