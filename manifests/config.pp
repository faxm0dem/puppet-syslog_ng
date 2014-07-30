define syslog_ng::config (
	$content = "",
    $order => '5'
) {
    concat::fragment { $title:
        target  => $syslog_ng::params::config_file,
        content => $content,
        order => $order
    }
}
