define syslog_ng::source (
	$id = $title,
	$type = 'system',
	$options = {}
) {

    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_source($id, $type, $options)
    }
}
