module Puppet::Parser::Functions
  newfunction(:generate_destination, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall 
    id = args[0]
    params = args[1]
    function_generate_src_dst(["destination", id, params])
  end
end
