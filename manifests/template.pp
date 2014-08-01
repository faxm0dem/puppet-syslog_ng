define syslog_ng::template (
	$params = []
) {
    $type = 'template'
    $id = $title
    $order = '20'
    
    concat::fragment { $title:
        target  => "$syslog_ng::$tmp_config_file",
        content => generate_statement($id, $type, $params),
        order => $order
    }
}
