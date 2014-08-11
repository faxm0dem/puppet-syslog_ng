require 'spec_helper'

describe 'generate_statement' do

    let(:scope) { PuppetlabsSpec::PuppetInternals.scope }
    let(:title) {'r_name'}
    let(:type) {'rewrite'}
    let(:param1) {{
        'type' => 'subst',
        'options' => [
            %q!'string'!,
            %q!'replacement'!,
            { 'value' => ['field'] },
            { 'flags' => []}
        ]
    }}
    let(:param1_expected) {
%q!rewrite r_name {
    subst(
        'string',
        'replacement',
        value(field),
        flags()
    );
};
!}
#    it 'Should raise an exception with not Hash or Array param' do
#        result = scope.function_generate_statement([title, type, param1])
#        expect{scope.function_generate_statement([title, type, param1])}.to raise_error
#    end

    context "Array notation with one item can be omitted" do
        let(:param1) {{
            'type' => 'subst',
            'options' => [
                %q!'string'!,
                %q!'replacement'!,
                { 'value' => 'field' },
                { 'flags' => ''}
            ]
        }}
        it 'On parameters of options' do
            result = scope.function_generate_statement([title, type, [param1]])
            expect(result).to be_a String
            expect(result).to eq param1_expected
        end

        it 'On options' do
            result = scope.function_generate_statement([title, type, param1])
            expect(result).to be_a String
            expect(result).to eq param1_expected
        end

    end

    context "Array notation with one item can be omitted" do
        let(:param1) {{
            'type' => 'subst',
            'options' => [
                %q!'string'!,
                %q!'replacement'!,
                { 'value' => 'field' },
                { 'flags' => 'ignore-case, store-matches'}
            ]
        }}
        let(:param1_expected) {
%q!rewrite r_name {
    subst(
        'string',
        'replacement',
        value(field),
        flags(ignore-case, store-matches)
    );
};
!}

        it 'On parameters of options' do
            result = scope.function_generate_statement([title, type, [param1]])
            expect(result).to be_a String
            expect(result).to eq param1_expected
        end

        it 'On options' do
            result = scope.function_generate_statement([title, type, param1])
            expect(result).to be_a String
            expect(result).to eq param1_expected
        end
 
    end

    context "With simple options" do
        let(:params) {[param1]}
        it 'Should generate rewrite rule' do
            result = scope.function_generate_statement([title, type, params])
            expect(result).to be_a String
            expect(result).to eq param1_expected
        end
    end

    context "Array statement" do
        let(:type) { 'source' }
        let(:title) { 's_external' }
        let(:params) {[
            { 'type' => 'udp',
              'options' => [
                {'ip' => [%q!'192.168.42.2'!]},
                {'port' => [514]}
                ]
            },
            { 'type' => 'tcp',
              'options' => [
                {'ip' => [%q!'192.168.42.2'!]},
                {'port' => [514]}
                ]
            },
            {
              'type' => 'syslog',
              'options' => [
                {'flags' => ['no-multi-line', 'no-parse']},
                {'ip' => [%q!'10.65.0.5'!]},
                {'keep-alive' => ['yes']},
                {'keep_hostname' => ['yes']},
                {'transport' => ['udp']}
                ]
            }
        ]}
      let(:expected) {
%q!source s_external {
    udp(
        ip('192.168.42.2'),
        port(514)
    );
    tcp(
        ip('192.168.42.2'),
        port(514)
    );
    syslog(
        flags(no-multi-line, no-parse),
        ip('10.65.0.5'),
        keep-alive(yes),
        keep_hostname(yes),
        transport(udp)
    );
};
!}

        it 'Should generate source rule' do
            result = scope.function_generate_statement([title, type, params])
            expect(result).to be_a String
            expect(result).to eq expected
        end
    end
end
