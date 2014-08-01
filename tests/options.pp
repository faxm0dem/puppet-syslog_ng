include syslog_ng

syslog_ng::options { "global_options":
    options => {
        'bad_hostname' => "'no'",
        'time_reopen'  => 10
    }
}
