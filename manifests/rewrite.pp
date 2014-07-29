define syslog_ng::rewrite (
	$params = []
) {
    $type = 'rewrite'
    $id = $title
    $order = '30'
    
    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_statement($id, $type, $params),
        order => $order
    }
}
