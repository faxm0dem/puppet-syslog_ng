require 'stringio'

module Puppet::Parser::Functions
  newfunction(:generate_src_dst, :type => :rvalue) do |args|
    # needs a value check
    statement = args[0]
    id = args[1]
    params = args[2]
    buffer = StringIO.new
    indent = '    '
    buffer << "#{statement} #{id} {\n"
    
    type = params["type"]
    options = params["options"]

    buffer << indent << type <<  "(\n"
    built_options = []
    
    options.keys.sort.each do |option|
        value = options[option]
        
        if value.instance_of? String
            v = '"' + value + '"'
        elsif value.instance_of? Array
            v = value.join(", ")
        else
            v = value
        end

        formatted = indent * 2 + "#{option}(#{v})"
        built_options.push(formatted)
    end

    buffer << built_options.join(",\n")
    buffer << "\n"
    buffer << indent <<  ");\n"

    buffer << '};'
    buffer.string
  end
end
