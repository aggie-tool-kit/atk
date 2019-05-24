require 'etc'
require_relative '../../toolbox/cmd'
require_relative '../../toolbox/os'
require_relative '../../toolbox/download'

if OS.is? :mac
    # install homebrew, which should install command line tools
    -'/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    # # install git
    -'brew install git'
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
    # download the atk and project command 
    # download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/atk', as: './atk-protected-bin/atk')
    # download('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/interface/project', as: './atk-protected-bin/project')
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
end