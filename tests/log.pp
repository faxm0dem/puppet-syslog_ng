include ::syslog_ng

syslog_ng::log {'l':
    params => [
        {'source' => 's_external'},
        {'destination' => 'd_udp'}
    ]
}
