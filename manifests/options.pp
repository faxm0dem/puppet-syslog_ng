define syslog_ng::options (
	$options = {}
) {

    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_options($options)
    }
}
