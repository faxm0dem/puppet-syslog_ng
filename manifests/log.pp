define syslog_ng::log (
	$options = []
) {

    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_log($options)
    }
}
