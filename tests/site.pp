#import 'nodes.pp'

include syslog_ng

# the header written by this module has order == 1, so the version must be 02
syslog_ng::config {'version':
    content => '@version: 3.6',
    order => '02'
}

syslog_ng::options { 'global_options':
	options => {
		'bad_hostname' => "'no'"
	}
}

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

syslog_ng::log {'l':
    params => [
        {'source' => 's_external'},
        {'destination' => 'd_udp'}
    ]
}
