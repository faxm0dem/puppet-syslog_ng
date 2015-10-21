include ::syslog_ng

syslog_ng::config {'version':
    content => '@version: 3.6',
    order => '02'
}

$long_comment = '# Comment,
# wich spawns over multiple lines
# '

syslog_ng::config {'long_comment':
    content => $long_comment 
}
