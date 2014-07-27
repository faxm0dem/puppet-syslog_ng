require 'spec_helper'

describe 'syslog_ng::options' do

    let(:facts)  {{ :concat_basedir => '/dne' }}

    context 'with simple params' do
        let(:title) { 'options' }
        let(:type) { 'file' }
        let(:options) {{}} 
             
        it do 
            should contain_concat__fragment(title)
        end
    end
end
