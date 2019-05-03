. "$PSScriptRoot\scoop_core.ps1"

$scoopStatus = $false
$proxyResponse = $false
$proxyUsername = ""
$proxyPassword = ""
$proxyCredChoice = ""
do {
    # Install Scoop. If error, get proxy config and try again
    try {
        Write-Output "Installing Scoop..."
        Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
        $scoopStatus = $true
    }
    catch {
        if (installed "scoop") {
            break
        }
        # If failed, ask if behind proxy
        Write-Output "We tried to install Scoop but it failed"
        $userResponse = Read-Host "Are you behind a proxy that you would like to configure? (Y/n) "
        # If yes, determine proxy config one would like to use
        if (-not ($userResponse -eq "Y" -or $userResponse -eq "y" -or $userResponse -eq "Yes" -or $userResponse -eq "yes" -or $userResponse -eq "")) {
            break
        }
        $proxyResponse = $true

        # Instructions from Scoop
        ## If you want to use a proxy that isn't already configured in Internet Options
        ## [net.webrequest]::defaultwebproxy = new-object net.webproxy "http://proxy.example.org:8080"
    
        ## If you want to use the Windows credentials of the logged-in user to authenticate with your proxy
        ## [net.webrequest]::defaultwebproxy.credentials = [net.credentialcache]::defaultcredentials
    
        ## If you want to use other credentials (replace 'username' and 'password')
        ##[net.webrequest]::defaultwebproxy.credentials = new-object net.networkcredential 'username', 'password'

        $proxyLoc = Read-Host "What is the location of the proxy you want to use? (i.e. http://proxy.example.org:8080) "
        [net.webrequest]::defaultwebproxy = new-object net.webproxy "$proxyLoc"
        
        Write-Output "Which of the following options would you like to try? (Enter the option number)"
        Write-Output "[1] Use the Windows credentials of the logged-in user to authenticate with your proxy"
        Write-Output "[2] Use other credentials"
        Write-Output "[3] No credentials"
        $proxyCredChoice = Read-Host ""

        switch ($proxyCredChoice) {
            1 {
                [net.webrequest]::defaultwebproxy.credentials = [net.credentialcache]::defaultcredentials
            }
            2 {
                $proxyUsername = Read-Host "Username: "
                $proxyPassword = Read-Host "Password: " -AsSecureString

                $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($proxyPassword)
                # Converting secure pass to plain (temporary) in order to configure proxy credentials
                $plainPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
                [net.webrequest]::defaultwebproxy.credentials = new-object net.networkcredential $proxyUsername, $plainPass
                $plainPass = ""
            }
            Default {}
        }

    }

} until ($scoopStatus)

# TODO: Add Scoop proxy configuration
if ($proxyResponse) {
    Write-Output "You will need to configure Scoop to use your proxy as we just used your configuration fo installation."
    Write-Output "To do so, please check out the Scoop documentation and follow the instructions, then rerun this script:"
    Write-Output "https://github.com/lukesampson/scoop/wiki/Using-Scoop-behind-a-proxy#configuring-scoop-to-use-your-proxy"
    return
}

# TODO: Add check if Ruby is already installed

# Install Ruby 2.6.3
Invoke-Expression "scoop install ruby\@2.6.3" # TODO: Need to verify this version is correct

# Start Ruby install script for Windows