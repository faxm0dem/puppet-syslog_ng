require 'spec_helper'

describe 'generate_statement' do

    let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

    context "With simple options" do
        let(:title) {'r_name'}
        let(:type) {'rewrite'}
        let(:params) {[
                'type' => 'subst',
                'options' => [
                    "string",
                    "replacement",
                    { 'value' => ['field'] },
                    { 'flags' => []}
                ]
            ]
        }
        let(:expected) {
'rewrite r_name {
    subst(
        "string",
        "replacement",
        value(field),
        flags()
    );
};
'     }
        it 'Should generate rewrite rule' do
            result = scope.function_generate_statement([title, type, params])
            expect(result).to be_a String
            expect(result).to eq expected
        end
    end
end
