syslog_ng::parser {'p_hostname_segmentation':
    params => {
        'type' => 'csv-parser',
        'options' => [
            {'columns' => [
                '"HOSTNAME.NAME"',
                '"HOSTNAME.ID"'
            ]},
            {'delimiters' => '"-"'},
            {'flags' => 'escape-none'},
            {'template' => '"${HOST}"'}
        ]
    }
}

