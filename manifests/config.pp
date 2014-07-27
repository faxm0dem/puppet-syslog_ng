define syslog_ng::config (
	$content = ""
) {

    concat::fragment { $title:
        target  => $syslog_ng::params::config_file,
        content => $content
    }
}
