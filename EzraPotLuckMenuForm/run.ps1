using namespace System.Net
param($Request, $TriggerMetadata)
$html = html {
    head {
        Title -Content "iAddEmployee"
        Link -href "https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" -rel "stylesheet"
        script -src "https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" -type "text/javascript"
        script -src "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" -type "text/javascript"
        script -src "https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" -type "text/javascript"
    }

    body {
        div -Class "jumbotron text-center" -Content {
            h1 -Content "Ezra Pot Luck Menu"
            p -Content "Submit your menu..."
        }

        Div -Class "container" -Content {
            form -Class "form-horizontal" -action "/api/EzraPotLuckMenuUpdate" -method "post" -target "_blank" -Attributes @{'autocomplete' = 'OFF' } -enctype 'application/x-www-form-urlencoded' -Content {
                
                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'ID' } -Content "Employee ID"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "ID" -name "ID"
                        small -Id 'IDHelp' -Class 'form-text text-muted' -Content "Format 000X - Example 0001"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'FirstName' } -Content "First Name"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "FirstName" -name "FirstName"
                        small -Id 'FirstNameHelp' -Class 'form-text text-muted' -Content "Free Text - Example Chendrayan"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'SurName' } -Content "Sur Name"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "SurName" -name "SurName"
                        small -Id 'SurNameHelp' -Class 'form-text text-muted' -Content "Free Text - Example Venkatesan"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'date' } -Content "Date"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "date" -name "date" -value ((Get-Date).ToShortDateString())
                        small -Id 'dateHelp' -Class 'form-text text-muted' -Content "Free Text - Example 01/03/2005"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'Category' } -Content "Category"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "Category" -name "Category"
                        small -Id 'CategoryHelp' -Class 'form-text text-muted' -Content "Free Text - VEG"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'Dish' } -Content "Dish"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "Dish" -name "Dish"
                        small -Id 'DishHelp' -Class 'form-text text-muted' -Content "Lamb Biriyani"
                    }
                }

                Div -Class "form-group" -Content {
                    Div -Class "col-sm-offset-2 col-sm-10" -Content {
                        button -Content "Submit" -Class "btn btn-default" -Attributes @{"type" = "submit" }
                    }
                }
            }
        }
    }
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        headers    = @{'content-type' = 'text/html' }    
        StatusCode = [HttpStatusCode]::OK
        Body       = $html
    })