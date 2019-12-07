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