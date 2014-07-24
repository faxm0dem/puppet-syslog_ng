define syslog_ng::source (
	$id = $title,
	$type = 'system',
	$options = {}
) {

    concat::fragment { $title:
        target  => $syslog_ng::config_file,
        content => generate_source($id, $type, $options)
    }
}
