param 
(
    $Path
)

if($Path -eq $null)
{
    $Path = Get-Location
}

$AuditFileList = @()

Get-ChildItem $Path | ForEach-Object {
    if(Test-IsBinary.ps1 $_ -eq $true)
    {
        $AuditFileList += $_
        Remove-Item $_
    }
}

return $AuditFileList