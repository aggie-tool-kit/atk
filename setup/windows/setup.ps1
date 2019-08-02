# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd C:\$HOMEPATH

# TODO:
    # - check if ruby is already installed, and what version
    # - check if python is already installed, and what version
set PATH=$PATH;C:\$HOMEPATH\scoop\shims


# install git
scoop install git
# install ruby & gem
scoop install ruby
set PATH=$PATH;C:\$HOMEPATH\scoop\apps\current\bin
set PATH=$PATH;C:\$HOMEPATH\scoop\apps\ruby\current\bin
# install atk_toolbox
scoop\apps\current\bin\gem.cmd install atk_toolbox
# install python3 & pip3
scoop install python
# install asciimatics and ruamel.yaml
scoop\apps\python\current\Scripts\pip.exe install asciimatics ruamel.yaml
# download and run the script
C:\$HOMEPATH\scoop\apps\ruby\current\bin\ruby.exe -e (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb')