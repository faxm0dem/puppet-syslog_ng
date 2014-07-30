include syslog_ng

syslog_ng::config {'version':
    content => '@version: 3.6',
    order => '0'
}

syslog_ng::config {'comment_1':
    content => '#Some comment or configuration'
}
