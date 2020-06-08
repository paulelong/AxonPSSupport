# Usage: Get-DateRange SearchPath
# Shows a list of the dates covered by each log file for instance:
# PS> Get-DateRange.ps1 E:\users\Paul\Downloads\taser_body_cam_3-X6039CC7U*
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

$filerangestart = @{} 
$filerangeend = @{} 

foreach($file in $filelist)
{
  $firstline = $null
  foreach($line in [System.IO.File]::ReadLines($file)) 
  {
    if($firstline -eq $null)
    {
      if($line.Length -gt 15)
      {
        $firstdatestr = $line.Substring(0, 15) + "Z"
        [datetime]$firstdate = New-Object datetime
        if([datetime]::TryParseExact($firstdatestr, "MMM dd HH:mm:ssZ", 
          [System.Globalization.CultureInfo]::InvariantCulture,
          [System.Globalization.DateTimeStyles]::None,
          [ref]$firstdate))
        {
          $filerangestart[$file] = $firstdate
          $firstline = $line
        }
        else {
          if([datetime]::TryParseExact($firstdatestr, "MMM  d HH:mm:ssZ", 
          [System.Globalization.CultureInfo]::InvariantCulture,
          [System.Globalization.DateTimeStyles]::None,
          [ref]$firstdate))
          {
            $filerangestart[$file] = $firstdate
            $firstline = $line
          }
          else
          {
            echo "$($file.Name) start date failed to parse date result was $firstdatestr"
            echo "   $line"
          }
        }
      }
      else
      {
        echo "Invalid line in $($file.Name) too short"
        echo "   $line"
      }
    }

    if($line.Length -gt 15)
    {
      $lastline = $line
    }
  }

  $lastdatestr = $lastline.Substring(0, 15) + "Z"

  [datetime]$lastdate = New-Object datetime
  if([datetime]::TryParseExact($lastdatestr, "MMM dd HH:mm:ssZ", 
    [System.Globalization.CultureInfo]::InvariantCulture,
    [System.Globalization.DateTimeStyles]::None,
    [ref]$lastdate))
  {
    $filerangeend[$file] = $lastdate
  }
  else {
    if([datetime]::TryParseExact($lastdatestr, "MMM  d HH:mm:ssZ", 
    [System.Globalization.CultureInfo]::InvariantCulture,
    [System.Globalization.DateTimeStyles]::None,
    [ref]$lastdate))
    {
      $filerangeend[$file] = $lastdate
    }
    else
    {
      echo "$($file.Name) Failed to parse $lastline result was $lastdatestr"
    }
  }
}

$nfr = $filerangestart.GetEnumerator() | sort -Property value

$lastlastdate = $null

echo ""
echo "List of files in order"

foreach($i in $nfr)
{
  if($lastlastdate -ne $null)
  {
    $span = $i.value - $lastlastdate
    if($span.Seconds -gt 10)
    {
      echo "       ***** GAP *****"
    }
  }

  if($doGMT)
  {
    Write-Host (" {0} - {1} {2}" -f $i.value.ToUniversalTime().tostring("MMM dd HH:mm:ss"),$filerangeend[$i.Name].ToUniversalTime().tostring("MMM dd HH:mm:ss"),$i.Name.Name)
  }
  else
  {
    Write-Host (" {0} - {1} {2}" -f $i.value.tostring("MMM dd HH:mm:ss"),$filerangeend[$i.Name].tostring("MMM dd HH:mm:ss"),$i.Name.Name)
  }

  $lastlastdate = $filerangeend[$i.Name]
}


