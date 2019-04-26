require 'safe_yaml'

# 
# OS objects 
# 
    # TODO: create an official heirarchy/listing of versions
    # create a method on each for
        # setting aliases (save them to info.yaml)
        # setting environment variables
    class Windows
        def initialize
            
        end
    end
    
    class Mac
        def initialize
            
        end
    end
    
    class Linux
        def initialize
            
        end
    end
# 
# Create the OS array 
# 
    if (/darwin/ =~ RUBY_PLATFORM) != nil
        @OS = [ "mac" ]
    elsif (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
        @OS = [ "windows" ]
    else
        @OS = [ "linux" ]
    end

# 
# info.yaml tools
# 
    # project info (specific to operating sytem)
    # setting/getting values via an object (instead of opening/closing a file)
    class Info
        attr_accessor :data
        def initialize()
            
        end
        
        def [](element)
            the_file          = File.open("./info.yaml")
            file_content_copy = the_file.read
            the_file.close
            @data = YAML.load(file_content_copy, :safe => true)
            if @data.is_a? Hash
                if @data[ @OS[0] ]
                    @data = @data[ @OS[0] ]
                end
            end
            return @data[element.to_s]
        end
    end
    @Info = Info.new


