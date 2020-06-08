$d = get-clipboard -Format FileDropList
$tempname = [System.IO.Path]::GetTempFileName()

foreach($f in $d)
{
    cat $f >> $tempname
}

&"E:\Users\Paul\Documents\Bin\TextAnalysisTool.NET.exe" $tempname

