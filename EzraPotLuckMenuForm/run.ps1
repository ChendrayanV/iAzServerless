using namespace System.Net
$html = html -Content {
    head -Content {

    }

    body -Content {
        
    }
}
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
