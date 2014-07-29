syslog_ng::source { "s_gsoc":
    params => {
        'type' => 'file',
        'options' => {
            'file' => '/var/log/apache.log',
            'follow_freq' => '1'
        }
    }
}

syslog_ng::source {'s_external':
    params => [
        { 'type' => 'udp',
          'options' => [
            {'ip' => ['192.168.42.2']},
            {'port' => [514]}
            ]
        },
        { 'type' => 'tcp',
          'options' => [
            {'ip' => ['192.168.42.2']},
            {'port' => [514]}
            ]
        },
        {
          'type' => 'syslog',
          'options' => [
            {'flags' => ['no-multi-line', 'no-parse']},
            {'ip' => ['10.65.0.5']},
            {'keep-alive' => ['yes']},
            {'keep_hostname' => ['yes']},
            {'transport' => ['udp']}
            ]
        }
    ]
} 
