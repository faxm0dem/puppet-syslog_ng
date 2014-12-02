define syslog_ng::parser (
  $params = []
) {
  $type = 'parser'
  $id = $title
  $order = '40'
    
  concat::fragment { $title:
    target  => $::syslog_ng::tmp_config_file,
    content => generate_statement($id, $type, $params),
    order => $order
  }
}
