require 'spec_helper'
describe 'syslog_ng' do

  context 'with defaults for all parameters' do
    it { should contain_class('syslog_ng') }
  end
end
