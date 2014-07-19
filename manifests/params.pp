class syslog_ng::params {

  $options = {
    'chain_hostnames' => 0,
    'time_reopen' => 10,
    'time_reap' => 360,
    'log_fifo_size' => 2048,
    'create_dirs' => 'yes',
    'group' => 'adm',
    'perm' => '0640',
    'dir_perm' => '0755',
    'use_dns' => 'no'
  }

}
