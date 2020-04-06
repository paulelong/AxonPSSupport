param
(
    $enabled
)

    $e = [boolean]$enabled

    if($e -eq $true)
    {
        Write-Host "Enabling WSL"
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    } elseif ($enabled -eq $false){
        Write-Host "Disabling WSL"
        Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    }
    else {
        Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    }
