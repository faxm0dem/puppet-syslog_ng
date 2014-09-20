require 'spec_helper'

describe 'syslog_ng' do

  let(:facts)  {{ :concat_basedir => '/dne',
                  :osfamily => 'Ubuntu',
                  :operatingsystem => 'Ubuntu'
  }}

  context 'With not default params' do
    let(:params) {{
      :config_file => '/tmp/puppet-test/syslog-ng.conf',
      :sbin_path => '/home/tibi/install/syslog-ng'
    }}
    it {
      should contain_package('syslog-ng-core')
      should contain_service('syslog-ng')
    }
  end
end
