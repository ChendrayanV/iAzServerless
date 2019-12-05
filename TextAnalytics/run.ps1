using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

$Uri = "https://southeastasia.api.cognitive.microsoft.com/text/analytics/v2.1/languages"
$APIKey = $ENV:TextAnalyticsKey

$wishes = Get-Content .\database\wishes.json

$result = Invoke-RestMethod -Uri $Uri -Headers @{
    "Ocp-Apim-Subscription-Key" = $APIKey
} -Body $wishes -Method Post -ContentType "application/json"

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
