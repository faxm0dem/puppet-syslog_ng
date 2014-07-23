
module Puppet::Parser::Functions
  newfunction(:generate_source, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall 
    id = args[0]
    params = args[1]
    function_generate_src_dst(["source", id, params])
  end
end
