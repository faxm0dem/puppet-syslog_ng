syslog_ng::options { "global_options":
    options => {
        'chain_hostnames' => 0,
        'time_reopen' => 10,
        'time_reap' => 360,
        'log_fifo_size' => 2048,
    }
}
