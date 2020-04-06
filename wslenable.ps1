param
(
    $enabled
)

    $e = [boolean]$enabled

    if($e -eq $true)
    {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    } elseif ($enabled -eq $false){
        Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    }
    else {
        Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    }
