# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd

# TODO:
    # - check if ruby is already installed, and what version
    # - check if python is already installed, and what version

# install git
scoop\shims\scoop.cmd install git
# install ruby & gem
scoop\shims\scoop.cmd install ruby
# install atk_toolbox
scoop\apps\current\bin\gem.cmd install atk_toolbox
# install python3 & pip3
scoop\shims\scoop.cmd install python
# install asciimatics and ruamel.yaml
scoop\apps\python\current\Scripts\pip.exe install asciimatics ruamel.yaml
# download and run the script
# ruby -e (new-object net.webclient).downloadstring('https://get.scoop.sh')