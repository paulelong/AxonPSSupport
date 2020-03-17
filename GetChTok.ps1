param 
(
    $DevID
)

$response = Invoke-WebRequest -URI "http://$($DevID):8080/challenge-token"
$response.Content
