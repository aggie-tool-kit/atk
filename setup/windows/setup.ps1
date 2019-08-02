# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd $Home


# create something for updating ENV variables without constantly needing to restart the CMD window
$program_1 = @"
Set oShell = WScript.CreateObject("WScript.Shell")
filename = oShell.ExpandEnvironmentStrings("%TEMP%\resetvars.bat")
Set objFileSystem = CreateObject("Scripting.fileSystemObject")
Set oFile = objFileSystem.CreateTextFile(filename, TRUE)

set oEnv=oShell.Environment("System")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next
path = oEnv("PATH")

set oEnv=oShell.Environment("User")
for each sitem in oEnv 
    oFile.WriteLine("SET " & sitem)
next

path = path & ";" & oEnv("PATH")
oFile.WriteLine("SET PATH=" & path)
oFile.Close
"@

$program_2 = @"
@echo off
%~dp0resetvars.vbs
call "%TEMP%\resetvars.bat"
"@

New-Item -Path . -Name "resetvars.vbs" -ItemType "file" -Value $program_1
New-Item -Path . -Name "resetvars.bat" -ItemType "file" -Value $program_2

# TODO:
    # - check if ruby is already installed, and what version
    # - check if python is already installed, and what version
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
$setup_script = (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb')
New-Item -Path . -Name "setup.rb" -ItemType "file" -Value $setup_script
cmd /c "
    .\resetvars.bat
    ruby setup.rb
"