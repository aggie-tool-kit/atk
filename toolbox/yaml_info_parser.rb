require 'yaml'
require_relative './cmd'
require_relative './os'

# 
# Create loaders for ruby code literal and console code literal
# 
    class Code
        @@tags = {}
        def self.tags
            return @@tags
        end
        
        def self.register_as(yaml_tag_name)
            YAML.add_tag(yaml_tag_name, self.class)
            Code.tags[yaml_tag_name] = self.class
        end
        
        def init_with(coder)
            @value = coder.scalar
        end
        
        def run
            # TODO: improve this error message
            raise "This needs to be overloaded"
        end
        
        def to_s
            puts @value
        end
    end
    
    # 
    # Ruby Code/Evaluation
    # 
    class RubyCode < Code
        def run
            eval(@value)
        end
    end
    RubyCode.register_as('!language/ruby')
    # add an evaluater for ruby code
    ruby_evaluation_tag = 'evaluate/ruby'
    Code.tags[ruby_evaluation_tag] = "evaluate"
    YAML.add_domain_type("", ruby_evaluation_tag) do |type, value|
        if value.is_a? String
            eval(value)
        else
            value
        end
    end

    # 
    # Console Code
    # 
    # TODO: add support for console code
    class ConsoleCode < Code
        def run
            -"#{@value}"
        end
    end
    ConsoleCode.register_as('!language/console')
# 
# project info (specific to operating sytem)
# 
# setting/getting values via an object (instead of opening/closing a file)
class Info
    # main keys
        # (using_atk_version)
        # (project)
        # (advanced_setup)
    # any-level project detail keys:
        # (dependencies)
        # (project_commands)
        # (structures)
        # (local_package_managers)
        # (put_new_dependencies_under)
        # (environment_variables)
    
    # TODO: figure out a way of adding write access to the info.yaml
    # TODO: if there is no (using_atk_version), then add one with the current version
    # TODO:
    #     if there is no (project) or no (advanced_setup), then assume its not an ATK setup 
    #     (quit somehow depending on how this code was invoked)
    # TODO:
    #    if there are ()'s in a key inside of the (project)
    #    but the key isn't part of the standard keys
    #    then issue a warning, and give them a suggestion to the next-closest key
    
    @@data = nil
    @@valid_variables = ['context', 'os']
    @@valid_operators = ['is']
    
    # TODO: write tests for this function
    def self.parse_when_statment(statement)
        # remove the 'when' and paraentheses
        expression = statement.sub( /when\((.*)\)/, "\\1" )
        # create the pattern for finding variables
        variable_pattern = /\A\s*--(?<variable>#{@@valid_variables.join('|')})\s+(?<operator>#{@@valid_operators.join('|')})\s+(?<value>.+)/
        groups = expression.match(variable_pattern)
        if groups == nil
            raise "\n\nIn the info.yaml file\nI couldn't any of the variables in #{statement}\nMake sure the format is:\n    when( --VARIABLE *space* OPERATOR *space* VALUE )\nvalid variables are: #{valid_variables}\nvalid operators are: #{valid_operators}"
        end
        value = groups['value'].strip
        
        substitutions = ->(value) do
            value.gsub!( /\\'/, "'" )
            value.gsub!( /\\"/, '"' )
            value.gsub!( /\\n/, "\n" )
            value.gsub!( /\\t/, "\t" )
        end
        
        # if it has single quotes
        if value =~ /'.+'/
            value.sub!( /'(.+)'/, "\\1" )
            substitutions[value]
        # if double quotes
        elsif value =~ /".+"/
            value.sub!( /"(.+)"/, "\\1" )
            substitutions[value]
        else
            raise "\n\nIn the info.yaml file\nthe value: #{value} in the statment:\n#{statement}\n\nwas invalid. It probably needs single or double quotes around it"
        end
        
        return {
            variable: groups['variable'],
            operator: groups['operator'],
            value: value
        }
    end
    
    def self.evaluate_when_condition(data)
        case data[:variable]
        when 'context'
            raise "\n\ncontext functionality has not been implemented yet"
        when 'os'
            case data[:operator]
                when 'is'
                    return OS.is?(data[:value])
                else
                    raise "unknown operator: #{data[:operator]}"
            end
        else
            raise "\n\nunknown variable: #{data[:variable]}"
        end
    end
    
    # def self.parse_language_evaluations(value)
    #     if value.is_a?(Evaluation)
    #         return Info.parse_language_evaluations(value.run())
    #     elsif value.is_a?(Hash)
    #         new_hash = {}
    #         for each_key, each_value in value
    #             new_hash[each_key] = Info.parse_language_evaluations(each_value)
    #         end
    #         return new_hash
    #     elsif value.is_a?(Array)
    #         new_array = []
    #         for each in value
    #             new_array.push(Info.parse_language_evaluations(each))
    #         end
    #         return new_array
    #     else
    #         return value
    #     end
    # end
    
    def self.parse_advanced_setup(unchecked_hashmap, current_project_settings)
        for each_key, each_value in unchecked_hashmap.clone()
            case
            # check for yaml-when statements
            when each_key =~ /\Awhen\(.*\)\z/ && each_value.is_a?(Hash)
                statement_data = Info.parse_when_statment(each_key)
                # if the when condition was true
                if Info.evaluate_when_condition(statement_data)
                    # recursively parse the tree
                    Info.parse_advanced_setup(each_value, current_project_settings)
                end
            # transfer all the normal keys to the current_project_settings
            else
                current_project_settings[each_key] = each_value
            end
        end
    end
    
    def self.load_if_needed
        # if the data hasn't been loaded then load it first
        if @@data == nil
            Info.load_from_yaml
        end
    end
    
    def self.load_from_yaml
        # this function sets up:
            # @@data
            # @@project
            # @@settings
            # and also
            # @@dependencies
            # @@project_commands
            # @@structures
            # @@local_package_managers
            # @@put_new_dependencies_under
            # @@environment_variables
        
        # get the local yaml file
        # TODO: have this search the parent dir's to find it 
        @@data = YAML.load_file("./info.yaml", :safe => true, whitelisted_tags: Code.tags.keys)
        @@project = @@data['(project)']
        if @@project == nil
            # TODO: maybe change this to be optional in the future and have default settings
            raise "\n\nThere is no (project): key in the info.yaml\n(so ATK is unable to parse the project settings)"
        end
        # TODO: remove this
        # @@project = Info.parse_language_evaluations(@@project)
        
        @@settings = @@project['(advanced_setup)']
        if @@settings == nil
            # TODO: maybe change this to be optional in the future and have default settings
            raise "\n\nThere is no (advanced_setup): key in the (project) of the info.yaml\n(so ATK is unable to parse the project settings)"
        end
        Info.parse_advanced_setup(@@settings, @@settings)
        @@dependencies               = @@settings['(dependencies)']
        @@project_commands           = @@settings['(project_commands)']
        @@structures                 = @@settings['(structures)']
        @@local_package_managers     = @@settings['(local_package_managers)']
        @@put_new_dependencies_under = @@settings['(put_new_dependencies_under)']
        @@environment_variables      = @@settings['(environment_variables)']
    end
    
    # accessors
    def self.data()                       Info.load_if_needed; return @@data                        end
    def self.project()                    Info.load_if_needed; return @@project                     end
    def self.settings()                   Info.load_if_needed; return @@settings                    end
    def self.dependencies()               Info.load_if_needed; return @@dependencies                end
    def self.project_commands()           Info.load_if_needed; return @@project_commands            end
    def self.structures()                 Info.load_if_needed; return @@structures                  end
    def self.local_package_managers()     Info.load_if_needed; return @@local_package_managers      end
    def self.put_new_dependencies_under() Info.load_if_needed; return @@put_new_dependencies_under  end
    def self.environment_variables()      Info.load_if_needed; return @@environment_variables       end
    
    # read access to the yaml file
    def self.[](element)
        Info.load_if_needed
        return @@data[element.to_s]
    end
end
