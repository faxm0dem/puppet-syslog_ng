syslog_ng::destination { 'd_udp':
    params => {
        'type' => 'udp',
        'options' => [
            "'127.0.0.1'",
            {'port' => '1999'},
            {'localport' => '999'}
        ]
    }
}

