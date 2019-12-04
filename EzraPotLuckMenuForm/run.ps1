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
            form -Class "form-horizontal" -action "/api/iUpdateEmployee" -method "post" -target "_blank" -Attributes @{'autocomplete' = 'OFF' } -enctype 'application/x-www-form-urlencoded' -Content {
                
                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'employeeID' } -Content "Employee ID"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "employeeID" -name "employeeID"
                        small -Id 'employeeIDHelp' -Class 'form-text text-muted' -Content "Format 00000X - Example 000001"
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
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'LastName' } -Content "Last Name"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "LastName" -name "LastName"
                        small -Id 'lastNameHelp' -Class 'form-text text-muted' -Content "Free Text - Example Venkatesan"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'dateofJoining' } -Content "Date Of Joining"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "dateofJoining" -name "dateofJoining"
                        small -Id 'dateofJoiningHelp' -Class 'form-text text-muted' -Content "Free Text - Example 01/03/2005"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'department' } -Content "Department"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "department" -name "department"
                        small -Id 'departmentHelp' -Class 'form-text text-muted' -Content "Free Text - IT"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'manager' } -Content "Manager"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "manager" -name "manager"
                        small -Id 'managerHelp' -Class 'form-text text-muted' -Content "Free Text - My Boss"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'country' } -Content "Country"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "country" -name "country"
                        small -Id 'countryHelp' -Class 'form-text text-muted' -Content "Free Text - India"
                    }
                }

                Div -Class "form-group" -Content {
                    label -Class "control-label col-sm-2" -Attributes @{'for' = 'city' } -Content "City"
                    Div -Class "col-sm-10" -Content {
                        input -type "text" -Class "form-control" -id "city" -name "city"
                        small -Id 'cityHelp' -Class 'form-text text-muted' -Content "Free Text - Bangalore"
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