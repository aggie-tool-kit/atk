# requires git, ruby, gem(atk_toolbox), python3, pip3(asciimatics, ruamel.yaml)
require 'atk_toolbox'

class String
    def -@
        Process.wait(Process.spawn(self))
        return $?.success?
    end
end

def download(input_1=nil, from:nil, url:nil, as:nil)
    require 'open-uri'
    # argument checking 
        # if only one argument, either input_1 or url
        if ((input_1!=nil) != (url!=nil)) && (from==nil) && (as==nil)
            # this covers:
            #    download     'site.com/file'
            the_url = url || input_1
            file_name = the_url.match /(?<=\/)[^\/]+\z/ 
            file_name = file_name[0]
        elsif (as != nil) && ((input_1!=nil)!=(url!=nil))
            # this covers:
            #    download     'site.com/file' as:'file'
            #    download url:'site.com/file' as:'file'
            the_url = url || input_1
            file_name = as
        elsif ((from!=nil) != (url!=nil)) && input_1!=nil
            # this covers:
            #    download 'file' from:'site.com/file'
            #    download 'file'  url:'site.com/file'
            the_url = from || url
            file_name = input_1
        else
            message_ = "I'm not sure how you're using the download function.\n"
            message_ << "Please use one of the following methods:\n"
            message_ << "    download     'site.com/file'\n"
            message_ << "    download     'site.com/file', as:'file'\n"
            message_ << "    download url:'site.com/file', as:'file'\n"
            message_ << "    download 'file', from:'site.com/file'\n"
            message_ << "    download 'file',  url:'site.com/file'\n"
            raise message_
        end

    # actually download the file
    open(file_name, 'wb') do |file|
        file << open(the_url).read
    end
end

# 
# create the file structure
# 
FileUtils.makedirs(HOME/"atk"/"installers")
# download the files
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/core.yaml'       , as: HOME/"atk"/"core.yaml")
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/installers.yaml' , as: HOME/"atk"/"installers.yaml")

#
# create the commands
# 

# atk
atk_command_download_path = HOME/"atk"/"temp"/"atk.rb"
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/atk'     , as: atk_command_download_path)
set_command("atk", IO.read(doubledash_command_download_path))

# project
project_command_download_path = HOME/"atk"/"temp"/"project.rb"
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/project' , as: project_command_download_path)
set_command("atk", IO.read(doubledash_command_download_path))

# --
doubledash_command_download_path = HOME/"atk"/"temp"/"doubledash_command.rb"
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/--'      , as: doubledash_command_download_path)
set_command("--", IO.read(doubledash_command_download_path))

