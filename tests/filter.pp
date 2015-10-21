include ::syslog_ng

syslog_ng::filter {'f_tag_filter':
    params => {
        'type' => 'tags',
        'options' => [
            '".classifier.system"'
        ]
    }
}

