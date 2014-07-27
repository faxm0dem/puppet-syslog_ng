require 'require_relative'
require_relative 'log'

module Puppet::Parser::Functions
  newfunction(:generate_log, :type => :rvalue) do |args|
    options = args[0]
   
    Log.generate_log(options) 
   end
end
