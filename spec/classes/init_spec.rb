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
  context 'When asked not to manage package' do
    let(:params) {{
      :manage_package => false
    }}
    it { should_not contain_package('syslog-ng-core') }
  end
  context 'When asked to use additional module' do
    let(:params) {{
      :modules => [ 'foo', 'bar', 'baz' ]
    }}
    it {
      should contain_syslog_ng__module('foo')
      should contain_syslog_ng__module('bar')
      should contain_syslog_ng__module('baz')
    }
  end
  context 'When asked to check syntax before reload' do
    let(:params) {{
      :syntax_check_before_reloads => true
    }}
    it {
      should contain_file('/tmp/syslog-ng.conf.tmp').that_notifies('Exec[syslog_ng_syntax_check]')
      should contain_exec('syslog_ng_syntax_check').that_notifies('Exec[syslog_ng_deploy_config]')
      should contain_exec('syslog_ng_deploy_config').that_notifies('Exec[syslog_ng_reload]')
    }
  end
  context 'When asked not to check syntax before reload' do
    let(:params) {{
      :syntax_check_before_reloads => false
    }}
    it {
      should contain_file('/tmp/syslog-ng.conf.tmp').that_notifies('Exec[syslog_ng_deploy_config]')
      should contain_exec('syslog_ng_deploy_config').that_notifies('Exec[syslog_ng_reload]')
    }
  end
end
