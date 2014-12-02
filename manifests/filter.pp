define syslog_ng::filter (
  $params = []
) {
  $type = 'filter'
  $id = $title
  $order = '50'

  concat::fragment { $title:
    target  => $::syslog_ng::tmp_config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
