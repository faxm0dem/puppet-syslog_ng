include syslog_ng

syslog_ng::rewrite{'r_rewrite_subst':
    params => {
        'type' => 'subst',
        'options' => [
            '"IP"',
            '"IP-Address"',
            {'value' => '"MESSAGE"'},
            {'flags' => 'global'}
        ]
    }
}

