$Serial = read-host
read-host
$Firmware = read-host
read-host
$ootpw = read-host
read-host
$SSHpw = read-host
read-host
$Expires = read-host

$global:ser = $Serial.SubString($Serial.LastIndexOf(": ") + 2)
$global:fw = $Firmware.SubString($Firmware.LastIndexOf(": ") + 2)
$global:supw = $ootpw.SubString($ootpw.LastIndexOf(": ") + 2)
$global:sshpw = $SSHpw.SubString($SSHpw.LastIndexOf(": ") + 2)
$global:ex = $Expires.SubString($Expires.LastIndexOf(": ") + 2)
