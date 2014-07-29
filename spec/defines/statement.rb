shared_examples_for "Statement" do |id, type|
    let(:facts)  {{ :concat_basedir => '/dne' }}

    let(:pre_condition) { 'include syslog_ng' }
    let(:title) { id }
    let(:type) { type }
    let(:options) {{}} 
         
    it do 
        should contain_concat__fragment(title)
    end
end
