require 'spec_helper'
describe 'syslog_ng' do

  context 'With params defined correctly' do
    let(:params) {{
      :config_file => '/tmp/puppet-test/syslog-ng.conf',
      :sbin_path => '/home/tibi/install/syslog-ng',
      :purge_syslog_ng_conf => true
    }}
    # it {
    #   should contain_file('/tmp/puppet-test/syslog-ng.conf')
    # }
  end
end
