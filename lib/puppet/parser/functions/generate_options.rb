require 'stringio'

module Puppet::Parser::Functions
  newfunction(:generate_options, :type => :rvalue) do |args|
    options = args[0]
    buffer = StringIO.new
    buffer << "options {\n"
    indent = '    '

    if options.length == 0
      return ""
    end

    options.each do |option, value|
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
