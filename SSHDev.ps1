param 
(
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
    $diff = $exdate = $curdate
    Write-Host "Token Expires in $diff"

    Write-Host "$DevID fw=$($firmware[$DevID]) expires $($ex[$DevID])"
    Write-Host "pw=$($sshpw[$DevID])"
    Write-Host "supw=$($supw[$DevID])"
    Write-Host "========================================================="
    
    ssh axuser@$DevID

}


