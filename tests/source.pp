include syslog_ng

syslog_ng::source { 's_gsoc':
    params => {
        'type' => 'tcp',
        'options' => {
            'ip' => "'127.0.0.1'",
            'port' => 1999
        }
    }
}

syslog_ng::source {'s_external':
    params => [
        { 'type' => 'udp',
          'options' => [
            {'ip' => ["'127.0.0.1'"]},
            {'port' => [514]}
            ]
        },
        { 'type' => 'tcp',
          'options' => [
            {'ip' => ["'127.0.0.1'"]},
            {'port' => [514]}
            ]
        },
        {
          'type' => 'syslog',
          'options' => [
            {'flags' => ['no-multi-line', 'no-parse']},
            {'ip' => ["'127.0.0.1'"]},
            {'keep-alive' => ['yes']},
            {'keep_hostname' => ['yes']},
            {'transport' => ['udp']}
            ]
        }
    ]
} 

