# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd

# install git
scoop\shims\scoop.cmd install git
# install ruby & gem
# install atk_toolbox
# install python3 & pip3
scoop\shims\scoop.cmd install python
# install asciimatics and ruamel.yaml
# download and run the script