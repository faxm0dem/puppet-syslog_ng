define syslog_ng::log (
	$params = []
) {

    $order = '80'
    concat::fragment { $title:
        target  => $syslog_ng::tmp_config_file,
        content => generate_log($params),
        order => $order
    }
}
