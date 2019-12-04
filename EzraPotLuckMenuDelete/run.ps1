using namespace System.Net
param($Request, $TriggerMetadata)
# Associate values to output bindings by calling 'Push-OutputBinding'.
$EzraPotLuckMenu = Get-Content .\database\EzraPotLuckMenu.json | ConvertFrom-Json
$EzraPotLuckMenu | Where-Object {$_.ID -ne ($Request.Body.ID)} | ConvertTo-Json | Set-Content .\database\EzraPotLuckMenu.json
$body = @{
    ID = $Request.Body.ID 
    message = "Remove from Database"
} | ConvertTo-Json
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'application/json' }
        StatusCode = [httpstatuscode]::OK
        Body       = $body
    })
