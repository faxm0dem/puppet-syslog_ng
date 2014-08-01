class syslog_ng::default_config {

    syslog_ng::config {"header comment":
        content => '
    # Default syslog-ng.conf file which collects all local logs into a
    # single file called /var/log/messages.
    #
    '}
    
    syslog_ng::config {'version':
        content => '@version: 3.6',
        order => '03'
    }
    
    syslog_ng::source {'s_local':
        params => [
            {
                'type' => 'system',
                'options' => ''
            },
            {   
                'type' => 'internal',
                'options' => ''
            }
        ]
    }
    
    syslog_ng::source {'s_local':
        params => 
            {   
                'type' => 'udp',
                'options' => ''
            }
    }
    
    syslog_ng::destination { 'd_local':
        params => 
            {
                'type' => 'file',
                'options' => [
                    "/var/log/messages"
                ]
            }
    }
    
    syslog_ng::log { 'l':
        params => [
            {'source' => 's_local'},
            {'destination' => 'd_local'}
        ]
    }
}
