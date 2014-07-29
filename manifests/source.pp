define syslog_ng::source (
	$params = []
) {
    $type = 'source'
    $id = $title
    $order = '60'
    
    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_statement($id, $type, $params),
        order => $order
    }
}
