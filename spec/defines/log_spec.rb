require 'spec_helper'

describe "syslog_ng::log" do

    let(:pre_condition) { 'include syslog_ng' }

    context "with params" do
        let(:title) { 'l_gsoc' }
        let(:statements) {{
            'source' => 's_gsoc',
            'source' => 's_local',
            'destination' => 'd_local'                
        }} 
        let(:facts)  {{ :concat_basedir => '/dne' }}
     
        it do 
            should contain_concat__fragment(title)
        end

    end
end
