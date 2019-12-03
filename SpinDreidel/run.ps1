using namespace System.Net
param($Request, $TriggerMetadata)

$body = [pscustomobject]@{
    Result = @('נ (nun)' , 'ג (gimel)' , 'ה (hei)' , 'ש (shin)') | Get-Random
} | ConvertTo-Json

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    headers  = @{'content-type' = 'application/json'}
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
