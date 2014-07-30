define syslog_ng::log (
	$params = []
) {

    $order = '80'
    concat::fragment { $title:
        target  => $::syslog_ng::params::config_file,
        content => generate_log($params),
        order => $order
    }
}
