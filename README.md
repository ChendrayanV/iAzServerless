# iAzServerless

25 Days of Serverless

> For a demo purpose all my azure functions will have anonymous authentication.

## Challenge 1

[Task December 01, 2019](https://25daysofserverless.com/calendar/1)

### Requirement

Create a REST API endpoint that spins a dreidel and randomly returns נ (Nun), ג (Gimmel), ה (Hay), or ש (Shin). This sounds like a great opportunity to use a serverless function to create an endpoint that any application can call!

### Solution

```PowerShell
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
```

### Usage

```PowerShell
PS C:\> Invoke-RestMethod -Uri "https://iazserverless.azurewebsites.net/api/SpinDreidel"
```

### Result

![Result](https://github.com/ChendrayanV/iAzServerless/blob/master/assets/Dreidel.jpg?raw=true)

## Challenge 7

[Task December 07, 2019](https://25daysofserverless.com/calendar/7)

### Requirement

Create an app to search and show image from unsplash. Allows multiple images! 

### Solution

> HTML UI for image search - Allows comma seperated values

```PowerShell
using namespace System.Net
param($Request, $TriggerMetadata)
$html = html {
    head {
        Title -Content "Unsplash Image"
        Link -href "https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" -rel "stylesheet"
        script -src "https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" -type "text/javascript"
        script -src "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" -type "text/javascript"
        script -src "https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" -type "text/javascript"
    }

    body {
        div -Class "jumbotron text-center" -Content {
            h1 -Content "Search Unsplash"
            p -Content {
                Link -href "https://source.unsplash.com/"
            }
        }

        Div -Class "container" -Content {
            form -Class "form-horizontal" -action "/api/iImageResult" -method "post" -target "_blank" -Attributes @{'autocomplete'='OFF'} -enctype 'application/x-www-form-urlencoded' -Content {
                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'Image Search'} -Content "Image Search"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "Image Search" -name "Image Search"
                    }
                }

                Div -Class "form-group" -Content {
                    Div -Class "col-sm-offset-2 col-sm-10" -Content {
                        button -Content "Submit" -Class "btn btn-default" -Attributes @{"type" = "submit"}
                    }
                }
            }
        }
    }
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'text/html'}    
        StatusCode = [HttpStatusCode]::OK
        Body       = $html
    })
```

> Result
![Result](https://github.com/ChendrayanV/iAzServerless/blob/master/assets/UnspalshSearch.png?raw=true)

> Result Page

```PowerShell
using namespace System.Net;
using namespace System.Web;

param($Request, $TriggerMetadata)

$formdata = ([ordered]@{ })
$DecodedBody = [System.Web.HttpUtility]::UrlDecode($Request.Body)
($($DecodedBody) -split "&").ForEach( { $value = $_.split("="); $formdata.Add($value[0], $value[1]) })
$html = html -Content {
    head -Content {
        Title -Content "Image Result"
    }

    body -Content {
        $keywords = $($formdata.'Image Search') -split ","
        foreach ($keyword in $keywords) {
            img -src "https://source.unsplash.com/400x400/?$($keyword)" 
        }
    }
}
Push-OutputBinding -name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'text/html' }
        StatusCode = [HttpStatusCode]::OK
        Body       = $html
    })
```

> Query 
![Result](https://github.com/ChendrayanV/iAzServerless/blob/master/assets/ImageResult.png?raw=true)


