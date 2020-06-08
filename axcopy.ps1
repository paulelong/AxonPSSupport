param 
(
    $Path,
    $DevID
)

$exdate = Get-Date $ex[$DevID]
$curdate = Get-Date
$diff = $exdate - $curdate

if($exdate -lt $curdate)
{
    Write-Host "Token has expired $diff ago"
}
else {
    if($DevID -eq $null)
    {
        $DevID == $lastdevice
    }

    $diff = $exdate = $curdate
    Write-Host "Token Expires in $diff"

    Write-Host "$DevID fw=$($firmware[$DevID]) expires $($ex[$DevID])"
    Write-Host "pw=$($sshpw[$DevID])"
    Write-Host "supw=$($supw[$DevID])"
    Write-Host "========================================================="
    
    Set-Clipboard -value $sshpw[$DevID] 

    scp axuser@$($DevID):$($Path) .
}
