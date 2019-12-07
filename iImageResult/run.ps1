using namespace System.Net;
using namespace System.Web;

param($Request, $TriggerMetadata)

$formdata = ([ordered]@{ })
$DecodedBody = [System.Web.HttpUtility]::UrlDecode($Request.Body)
($($DecodedBody) -split "&").ForEach( { $value = $_.split("="); $formdata.Add($value[0], $value[1]) })
# $KeyWord = $formdata | ConvertFrom-Json 
$html = html -Content {
    head -Content {
        Title -Content "Image Result"
    }

    body -Content {
        $keywords = $($formdata.'Image Search') -split ","
        foreach($keyword in $keywords) {
            img -src "https://source.unsplash.com/400x400/?$($keyword)" 
        }
    }
}
Push-OutputBinding -name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'text/html' }
        StatusCode = [HttpStatusCode]::OK
        Body       = $html
    })