# TODO:
    # - check if ruby is already installed, and what version
    # - check if python is already installed, and what version
    # - cleanup the setup.rb download

# 
# install scoop
# 
if (-not (cmd.exe /c "where scoop")) {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
# go home
cd $Home


$reset_command = @"
@echo off
::
:: RefreshEnv.cmd
::
:: Batch file to read environment variables from registry and
:: set session variables to these values.
::
:: With this batch file, there should be no need to reload command
:: environment every time you want environment changes to propagate

echo | set /p dummy="Reading environment variables from registry. Please wait... "

goto main

:: Set one environment variable from registry key
:SetFromReg
    "%WinDir%\System32\Reg" QUERY "%~1" /v "%~2" > "%TEMP%\_envset.tmp" 2>NUL
    for /f "usebackq skip=2 tokens=2,*" %%A IN ("%TEMP%\_envset.tmp") do (
        echo/set %~3=%%B
    )
    goto :EOF

:: Get a list of environment variables from registry
:GetRegEnv
    "%WinDir%\System32\Reg" QUERY "%~1" > "%TEMP%\_envget.tmp"
    for /f "usebackq skip=2" %%A IN ("%TEMP%\_envget.tmp") do (
        if /I not "%%~A"=="Path" (
            call :SetFromReg "%~1" "%%~A" "%%~A"
        )
    )
    goto :EOF

:main
    echo/@echo off >"%TEMP%\_env.cmd"

    :: Slowly generating final file
    call :GetRegEnv "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" >> "%TEMP%\_env.cmd"
    call :GetRegEnv "HKCU\Environment">>"%TEMP%\_env.cmd" >> "%TEMP%\_env.cmd"

    :: Special handling for PATH - mix both User and System
    call :SetFromReg "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" Path Path_HKLM >> "%TEMP%\_env.cmd"
    call :SetFromReg "HKCU\Environment" Path Path_HKCU >> "%TEMP%\_env.cmd"

    :: Caution: do not insert space-chars before >> redirection sign
    echo/set Path=%%Path_HKLM%%;%%Path_HKCU%% >> "%TEMP%\_env.cmd"

    :: Cleanup
    del /f /q "%TEMP%\_envset.tmp" 2>nul
    del /f /q "%TEMP%\_envget.tmp" 2>nul

    :: Set these variables
    call "%TEMP%\_env.cmd"

    echo | set /p dummy="Done"
    echo .
"@
New-Item -Path "$Home\AppData\local\Microsoft\WindowsApps\" -Name "RefreshEnv.cmd" -ItemType "file" -Value $reset_command


$Env:path += "$Home\scoop\shims"

# install git
scoop install git
# install ruby & gem
scoop install ruby
$Env:path += "$Home\scoop\apps\ruby\current\bin"
# setup msys2 (for ruby)
scoop install msys2
"exit
" | msys2
# install atk_toolbox
& "$Home\scoop\apps\ruby\current\bin\gem.cmd" install atk_toolbox
# install python3 & pip3
scoop install python
# install asciimatics and ruamel.yaml
& "$Home\scoop\apps\python\current\Scripts\pip.exe" install asciimatics ruamel.yaml
# download and run the script
$install_script = (new-object net.webclient).downloadstring('https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/setup.rb')
New-Item -Path . -Name "setup.rb" -ItemType "file" -Value $install_script
ruby setup.rb