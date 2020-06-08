param 
(
    $DevID
)

$response = Invoke-WebRequest -URI "http://$($DevID):8080/challenge-token"
Set-Clipboard -value $response.Content 

Write-Output "Key saved to clipboard"
$response.Content
