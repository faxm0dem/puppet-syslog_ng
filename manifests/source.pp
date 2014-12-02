define syslog_ng::source (
  $params = []
) {
  include syslog_ng::params

  $type = 'source'
  $id = $title
  $order = '60'
    
  concat::fragment { $title:
    target  => $::syslog_ng::tmp_config_file,
      content => generate_statement($id, $type, $params),
      order => $order
  }
}
