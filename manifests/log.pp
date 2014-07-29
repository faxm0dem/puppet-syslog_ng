define syslog_ng::log (
	$params = []
) {

    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_log($params)
    }
}
