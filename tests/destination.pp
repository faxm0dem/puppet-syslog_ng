syslog_ng::destination { 'd_tcp':
    params => {
        'type' => 'tcp',
        'options' => [
            '"10.1.2.3"',
            {'port' => '1999'},
            {'localport' => '999'}
        ]
    }
}

