require 'etc'
puts "\e[H\e[2J" # clear the screen

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

# if they don't have homebrew
if not (-'command -v brew >/dev/null 2>&1')
    # install homebrew, which should install command line tools
    -'/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
end

# 
# create the atk-protected-bin, atk-bin
# 
# go to the home directory
Dir.chdir(Etc.getpwuid.dir)
Dir.mkdir('./atk')                   unless Dir.exist?('./atk')
Dir.mkdir('./atk/atk-bin')           unless Dir.exist?('./atk/atk-bin')
Dir.mkdir('./atk/atk-protected-bin') unless Dir.exist?('./atk/atk-protected-bin')
# change the permissions
Dir.chdir('./atk')

# take ownership of the folder
-'sudo chown "$(whoami)" atk-protected-bin'
# only the owner can write
-"sudo chmod -R u+xrw atk-bin"
-"sudo chmod -R u+xrw atk-protected-bin"

# download the core listing
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/core.yaml')
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/atk_animation.py')
# create the installed_packages file
IO.write("./installed_packages.yaml","")
# download commands
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/atk'    , as: './atk-protected-bin/atk')
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/project', as: './atk-protected-bin/project')
download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/--'     , as: './atk-protected-bin/--')
# 
# set the permissions
# 
# everyone can read/run
-"sudo chmod -R o+xr atk-bin"
-"sudo chmod -R o+xr atk-protected-bin"
-"sudo chmod -R g+xr atk-bin"
-"sudo chmod -R g+xr atk-protected-bin"
# only the owner can write
-"sudo chmod -R u+xrw atk-bin"
-"sudo chmod -R u+xrw atk-protected-bin"
# a password is needed to write to the protected bin
-"sudo chown root atk-protected-bin"

# 
# create the new path
# 
# add the folders to the path
paths = IO.read('/etc/paths')
# remove extra newlines 
paths = paths.gsub(/\n+/, "\n")
# remove the homebrew path
paths = paths.sub(/^\/usr\/local\/bin\n/, "")
# remove the system path
paths = paths.sub(/^\/usr\/bin\n/, "")
# remove previous atk paths
escaped_path = Regexp.escape("#{Etc.getpwuid.dir}/atk/atk-protected-bin\n")
paths = paths.sub(/^#{escaped_path}/, "")
escaped_path = Regexp.escape("#{Etc.getpwuid.dir}/atk/atk-bin\n")
paths = paths.sub(/^#{escaped_path}/, "")

# add the new paths
paths =
    # homebrew
    "/usr/local/bin\n"+
    # system
    "/usr/bin\n"+
    # protected atk
    "#{Etc.getpwuid.dir}/atk/atk-protected-bin\n"+
    # everything else
    paths+
    # normal atk
    "#{Etc.getpwuid.dir}/atk/atk-bin\n"

# save the paths to a file
File.open('./paths', 'w') do |file|
    file.write(paths)
end

# 
# change the existing path (dangerous section)
# 
# become the owner of paths
-"sudo chown $(whoami) /etc/paths"
# overwrite the old paths with the new paths
-'cp "$HOME/atk/paths" /etc/paths'
# give ownership back to root
-"sudo chown root /etc/paths"


# install the atk_toolbox gem
-'sudo /usr/bin/gem install atk_toolbox &>/dev/null'
`brew install git python3 &>/dev/null`
`pip3 install ruamel.yaml asciimatics &>/dev/null`
puts "\e[H\e[2J" # clear the screen
-'python3 ./atk_animation.py'