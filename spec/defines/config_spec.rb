require 'spec_helper'

describe 'syslog_ng::config' do

    let(:title) { 'v_gsoc' }
    let(:facts)  {{ :concat_basedir => '/dne' }}

    context 'without params' do
        it do 
            should contain_concat__fragment(title)
        end
    end

    context 'with params' do
        let(:content) { '# Some content, which should be written into the config file' } 
             
        it do 
            should contain_concat__fragment(title)
        end
    end
end
