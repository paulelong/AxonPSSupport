$Serial = read-host
read-host
$Firmware = read-host
read-host
$rootpw = read-host
read-host
$SSHpw = read-host
read-host
$Expires = read-host

$DevID = $Serial.SubString($Serial.LastIndexOf(": ") + 2)

if($global:firmware.Count -le 0)
{
     $global:firmware = @{} 
     $global:supw = @{}
     $global:sshpw = @{}
     $global:ex = @{}    
}

$global:firmware[$DevID] = $Firmware.SubString($Firmware.LastIndexOf(": ") + 2)
$global:supw[$DevID] = $rootpw.SubString($rootpw.LastIndexOf(": ") + 2)
$global:sshpw[$DevID] = $SSHpw.SubString($SSHpw.LastIndexOf(": ") + 2)
$global:ex[$DevID] = $Expires.SubString($Expires.LastIndexOf(": ") + 2)
