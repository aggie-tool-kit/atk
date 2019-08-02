# TODO:
    # - check if ruby is already installed, and what version
    # - check if python is already installed, and what version
    # - remove chocolately after installation

# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd $Home

# 
# install chocolately to gain access to a "refreshenv" command
# 
$InstallDir='C:\ProgramData\chocoportable'
$env:ChocolateyInstall="$InstallDir"
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


$Env:path += "$Home\scoop\shims"

# install git
scoop install git
# install ruby & gem
scoop install ruby
$Env:path += "$Home\scoop\apps\ruby\current\bin"
# install atk_toolbox
& "$Home\scoop\apps\ruby\current\bin\gem.cmd" install atk_toolbox
# install python3 & pip3
scoop install python
# install asciimatics and ruamel.yaml
& "$Home\scoop\apps\python\current\Scripts\pip.exe" install asciimatics ruamel.yaml
# download and run the script
refreshenv
ruby -e (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb')