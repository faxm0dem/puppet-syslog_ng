require 'stringio'

module Puppet::Parser::Functions
  newfunction(:generate_options, :type => :rvalue) do |options|
    buffer = StringIO.new
    buffer << "options {\n"
    indent = '    '

    options.each do |option, value|
      buffer << indent
      buffer << option
      buffer << '('
      buffer << value
      buffer << ");\n"
    end
    buffer.string
  end
end
