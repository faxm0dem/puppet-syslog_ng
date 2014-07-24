syslog_ng::source { "s_gsoc":
    type => 'file',
    options => { 'file' => '/var/log/apache.log',
                 'follow_freq' => 1
    }
}
