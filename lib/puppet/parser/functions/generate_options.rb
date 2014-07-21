require 'stringio'

module Puppet::Parser::Functions
  newfunction(:generate_options, :type => :rvalue) do |args|
    options = args[0]
    sorted_options = Hash[options.sort]
    buffer = StringIO.new
    buffer << "options {\n"
    indent = '    '

    if options.length == 0
      return ""
    end

    sorted_options.each do |option, value|
      buffer << indent
      buffer << option
      buffer << '('
      buffer << value
      buffer << ");\n"
    end
    buffer << '};'
    buffer.string
  end
end
