require 'safe_yaml'
# 
# Create loaders for ruby code literal and console code literal
# 
    class RubyCode
        def init_with(coder)
            @value = coder.scalar
        end
        
        def run
            eval(@value)
        end
        
        # def to_s
        #     puts @value
        # end
    end
    YAML.add_tag( '!language/ruby', RubyCode )

    class ConsoleCode
        def init_with(coder)
            @value = coder.scalar
        end
        
        def run
            `#{@value}`
        end
        
        def to_s
            puts @value
        end
    end
    YAML.add_tag( '!language/console', ConsoleCode )
# 
# project info (specific to operating sytem)
# 
# setting/getting values via an object (instead of opening/closing a file)
class Info
    attr_accessor :data
    def initialize()
        
    end
    
    
    # any-level project detail keys:
        # (dependencies)
        # (project_commands)
        # (structures)
        # (local_package_managers)
        # (put_new_dependencies_under)
        # (environment_variables)
    
    # other keys
        # (using_atk_version)
        # (project)
        # (advanced_setup)
        # default(--context)
    
    # if there is no (project) or no (advanced_setup), then assume its not an ATK setup 
        # (quit somehow depending on how this code was invoked)
    
    # if there is no (using_atk_version), then add one with the current version
    # (using_atk_version) needs to appear in the root of the info.yaml
    # (project) needs to appear in the root of the info.yaml
    # (advanced_setup) needs to appear in the first level of the (project) key
    # default(--context) can only appear in the first level of (advanced_setup)
    # if there are ()'s in a key inside of the (project)
        # but the key isn't part of the standard keys
            # then issue a warning, and give them a suggestion to the next-closest key
    # if there is no when(--context is 'developer'), then create an empty one
    # if there is no (put_new_dependencies_under), then create one with a default value of 'developer'
    # if the path provided by (put_new_dependencies_under) is invalid, throw an error saying that
    
    def [](element)
        @data = YAML.load_file("./info.yaml", :safe => true)
        
        @project_details = {}
        
        # iterate through the tree in a DFS (one-line-after-another) manner
            # if the value is a `eval/language/ruby` type
                # then immediately run the ruby and (in the hashmap but not the info.yaml) make the result be the new value
            # if the key is a `default()`, then set the defaults[*key*] = *value*
            # if the key is a `when()`, then check the condition
                # if the condition is for --os
                    # if the comparison is 'is'
                        # then there are two cases to check
                            # see if it is a direct version match
                            # see if it is a group/category match (e.g. "unix_based" or "linux")
                    # right now 'is' is the only supported operator, so throw an error if its not 'is'
                # if the condition is for --context
                    # check the defaults[] variable for context
                    # check to see if this function was passed a context variable (which would have come from the command line)
            # if there is an any-level project keys
                # then overwrite any previous value with the new value
        
        return @data[element.to_s]
    end
end
@Info = Info.new


