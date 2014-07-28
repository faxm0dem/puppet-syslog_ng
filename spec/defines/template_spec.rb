require 'spec_helper'

describe 'syslog_ng::template' do

    let(:pre_condition) { 'include syslog_ng' }

    context 'with simple params' do
        let(:title) { 't_gsoc' }
        let(:type) { 'template' }
        let(:options) {{}} 
        let(:facts)  {{ :concat_basedir => '/dne' }}
     
        it do 
            should contain_concat__fragment(title)
        end
    end
end
