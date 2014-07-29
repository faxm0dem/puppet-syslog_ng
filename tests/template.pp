syslog_ng::template {'t_demo_filetemplate':
    params => [
        {
            'type' => 'template',
            'options' => [
                "$ISODATE $HOST $MSG\n"
            ]
        },
        {
            'type' => 'template_escape',
            'options' => [
                'no'
            ]
        }
    ]
}
