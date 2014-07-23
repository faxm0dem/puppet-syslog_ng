require 'spec_helper'

describe 'generate_src_dst' do

  let(:source) { "source" }
  let(:destination) { "destination" }

  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

    context "With simple options" do
        let(:title) { 's_gsoc' } 
        let(:params) {{ 'type' => 'file',
                        'options' => { 'file' => "/var/log/apache.log",
                                       'follow_freq' => 1}
        }}
    let(:expected) {
'source s_gsoc {
    file(
        file("/var/log/apache.log"),
        follow_freq(1)
    );
};'
}
    it 'Should generate a simple file source' do
        result = scope.function_generate_src_dst([source, title, params])
        expect(result).to be_a String
        expect(result).to eq expected
    end
 

    end



  context "With options" do
    let(:title) { 's_gsoc' } 
    let(:params) {{ 'type' => 'file',
                    'options' => { 'file' => "/var/log/apache.log",
                                   'follow_freq' => 1,
                                   'flags' => ['no_parse','validate_utf8']}
    }}
    let(:expected) {
'destination s_gsoc {
    file(
        file("/var/log/apache.log"),
        flags(no_parse, validate_utf8),
        follow_freq(1)
    );
};'

    }

    it 'Should fill the options statement' do
      result = scope.function_generate_src_dst([destination, title, params])
      expect(result).to be_a String
      expect(result).to eq expected
    end
  end

end
