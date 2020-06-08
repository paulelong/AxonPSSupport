<#
.Description
Looks for gaps of more than a second in syslogs
#>

# Example data
# Apr 24 17:01:02 - Apr 24 18:01:01 taser_body_cam_3-X6039CC7U-2020-04-24T22-12-36-401Z
# Apr 24 18:01:03 - Apr 24 18:11:54 taser_body_cam_3-X6039CC7U-2020-04-24T22-12-37-378Z
# Apr 24 18:11:55 - Apr 24 18:13:48 taser_body_cam_3-X6039CC7U-2020-04-24T22-42-38-189Z

param 
(
    $Path,
    $DoGMT=$false
)

if($Path -eq $null)
{
    $Path = "*"
}

$filelist = Get-ChildItem $Path

$lastdate = $null

foreach($file in $filelist)
{
    foreach($line in [System.IO.File]::ReadLines($file)) 
    {
        $curdatestr = $line.Substring(0, 15) + "Z"

        [datetime]$curdate = New-Object datetime
        if([datetime]::TryParseExact($curdatestr, "MMM d HH:mm:ssZ", [System.Globalization.CultureInfo]::InvariantCulture,
            [System.Globalization.DateTimeStyles]::None,
            [ref]$curdate))
        {
            if($lastdate -ne $null)
            {
                $datespan = $curdate - $lastdate
                if($datespan.Seconds -gt 15)
                {
                    echo "----------------------------------------------------"
                    echo "Time span greater than 15 second for $file"
                    echo "   $lastline"
                    echo "   $line"

                }
            }
            $lastdate = $curdate
            $lastline = $line
        }
        else 
        {
            echo "$file Failed to parse $line result was $curdatestr"
        }
    }
}


