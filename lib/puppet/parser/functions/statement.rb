require 'stringio'

module Statement
    
    def self.build_parameter(option, is_last, indent, buffer)
        if is_last
            tail =  ")\n"
        else
            tail = "),\n" 
        end       
        key = option.keys[0]
        value = option[key]
        
        buffer << indent << key << '('

        if value.is_a? Array
            buffer << value.join(', ')
        elsif value.is_a? String
            buffer << value        
        end
        buffer << tail

    end


    def self.build_options(options, indent, buffer)
        indent += '    '
        options.each_with_index do |option, i|
            if i == options.length - 1
                is_last = true
            end

            if option.is_a? String
                buffer << indent <<  option << ',' << "\n"
            elsif option.is_a? Hash
                build_parameter(option, is_last, indent, buffer)
            end
        end
    end

    def self.wrap_build_options(type, options, indent, buffer)
        buffer << indent << type << "(\n"
        build_options(options, indent, buffer)
        buffer << indent << ");\n"
    end

    def self.build_type(item, indent, buffer)
        if item.has_key?('type')
            type = item['type']
            options = item['options']
            wrap_build_options(type, options, indent, buffer)
        else
            type = item.keys[0]
            options = item[type]
            wrap_build_options(type, options, indent, buffer)
        end
    end

    def self.build_types(types, indent, buffer)
        indent += '    '
        if types.is_a? Array
            types.each do |item|
                build_type(item, indent, buffer)
            end     
        elsif types.is_a? Hash
            build_type(types, indent, buffer)
        else
            raise Puppet::ParseError, "You must use a Hash or an Array as the parameter"
        end
    end

    def self.generate_statement(id, type, params)
        buffer = StringIO.new
        indent = ''
        buffer << "#{type} #{id} {\n"
        build_types(params, indent, buffer)
        buffer << "};\n"
        return buffer.string

    end    

end

