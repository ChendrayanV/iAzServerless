using namespace System.Net
param($Request, $TriggerMetadata)
$body = html -Content {
    head -Content {
        Title -Content "Contoso EzraPotLuckMenuItem"
        Link -href 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css' -rel stylesheet
        script -src 'https://code.jquery.com/jquery-3.2.1.slim.min.js'
        script -src 'https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'
        script -src 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'
    }
    Body -Content {
        Div -Class 'container' -Content {
            Div -Class 'jumbotron' -Content {
                H1 -Class 'display-4' -Content "Ezra Potluck Menu"
            }
        }
        
        Div -Class 'container' -Content {
            $EzraPotLuckMenuItems = Get-Content .\database\EzraPotLuckMenu.json | ConvertFrom-Json
            Table -class 'table' -Content {
                Thead -Content {
                    Th -Content "ID"
                    Th -Content "First Name"
                    Th -Content "Sur Name"
                    Th -Content "Date"
                    Th -Content "Category"
                    Th -Content "Dish"
                }
                Tbody -Content {
                    foreach ($EzraPotLuckMenuItem in $EzraPotLuckMenuItems) {
                        tr -Content {
                            td -Content $EzraPotLuckMenuItem.ID
                            td -Content $EzraPotLuckMenuItem.FirstName
                            td -Content $EzraPotLuckMenuItem.SurName
                            td -Content $EzraPotLuckMenuItem.Date
                            td -Content $EzraPotLuckMenuItem.Category
                            td -Content $EzraPotLuckMenuItem.Dish
                        }
                    }
                }
            }
        }
    }
}
# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'text/html' }
        StatusCode = [httpstatuscode]::OK
        Body       = $body
    })