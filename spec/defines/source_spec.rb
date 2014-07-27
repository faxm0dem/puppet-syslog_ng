require 'spec_helper'

describe 'syslog_ng::source' do

    let(:pre_condition) { 'include syslog_ng' }

    context 'with simple params' do
        let(:title) { 's_gsoc' }
        let(:type) { 'file' }
        let(:options) {{}} 
        let(:facts)  {{ :concat_basedir => '/dne' }}
     
        it do 
            should contain_concat__fragment(title)
        end
    end
end
