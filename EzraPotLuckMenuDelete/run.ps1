using namespace System.Net
param($Request, $TriggerMetadata)
# Associate values to output bindings by calling 'Push-OutputBinding'.
$employees = Get-Content .\database\EzraPotLuckMenu.json | ConvertFrom-Json
$employees | Where-Object {$_.iD -ne ($Request.Body.iD)} | ConvertTo-Json | Set-Content .\database\EzraPotLuckMenu.json
$body = @{
    employeeName = $Request.Body.iD 
    message = "Remove from Database"
} | ConvertTo-Json
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'application/json' }
        StatusCode = [httpstatuscode]::OK
        Body       = $body
    })
