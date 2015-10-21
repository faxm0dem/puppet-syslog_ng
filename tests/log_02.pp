include ::syslog_ng

syslog_ng::log {'l2':
    params => [
        {'source' => 's_gsoc2014'},
        {'junction' => [
            {
            'channel' => [
                {'filter' => 'f_json'},
                {'parser' => 'p_json'}
            ]},
            {
            'channel' => [
                {'filter' => 'f_not_json'},
                {'flags' => 'final'}
            ]}
        ]
        },
        {'destination' => 'd_gsoc'}
    ]
}
