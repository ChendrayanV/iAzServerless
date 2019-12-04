using namespace System.Net
using namespace System.Web;
# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$formdata = ([ordered]@{ })
$DecodedBody = [System.Web.HttpUtility]::UrlDecode($Request.Body)
($($DecodedBody) -split "&").ForEach( { $value = $_.split("="); $formdata.Add($value[0], $value[1]) })
$EzraPotLuckMenu = Get-Content 'database\EzraPotLuckMenu.json' -Raw
$newMenu = ($formdata | ConvertTo-Json)
$result = ConvertFrom-Json -InputObject $EzraPotLuckMenu
$result += ConvertFrom-Json -InputObject $newMenu
$result | ConvertTo-Json | Set-Content 'database\EzraPotLuckMenu.json'
$body = @{
    message     = 'success'
    newMenu = $newMenu | ConvertFrom-Json
} | ConvertTo-Json

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'application/json' }
        StatusCode = [HttpStatusCode]::OK
        Body       = $body 
    })