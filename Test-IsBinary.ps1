param 
(
    $FileName
)


$fullpath = dir $FileName

$bytes = [System.IO.File]::ReadAllBytes($fullpath)
#$bytes = [System.IO.File]::ReadAllBytes(".\taser_body_cam_3-X603980JH-2020-04-10T22-17-14-551Z")

if($bytes[1] -lt 32)
{
    return $true
}
else 
{
    return $false
}