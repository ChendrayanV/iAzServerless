using namespace System.Net
param($Request, $TriggerMetadata)

$Uri = "https://southeastasia.api.cognitive.microsoft.com/text/analytics/v2.1/languages"
$wishes = Get-Content .\database\wishes.json
$languageResults = Invoke-RestMethod -Uri $Uri -Headers @{
    "Ocp-Apim-Subscription-Key" = $ENV:TextAnalyticsKey
} -Body $wishes -Method Post -ContentType "application/json"
$languageResults

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    headers = @{'content-type' = 'application/json'}
    StatusCode = [HttpStatusCode]::OK
    Body = $languageResults
})