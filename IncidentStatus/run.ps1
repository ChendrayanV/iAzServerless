using namespace System.Net
param($Request, $TriggerMetadata)
$user = $ENV:ServiceNowAdmin
$pass = $ENV:ServiceNowSecret
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $pass)))
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Authorization', ('Basic {0}' -f $base64AuthInfo))
$headers.Add('Accept', 'application/json')
$uri = "https://dev91470.service-now.com/api/now/table/incident?sysparm_display_value=true&sysparm_limit=100"
$method = "get"
$incidents = Invoke-RestMethod -Headers $headers -Method $method -Uri $uri 
$html = html -Content {
    head -Content {
        link -rel "stylesheet" -href "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" -integrity "sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" -crossorigin "anonymous"
        script -src "https://code.jquery.com/jquery-3.2.1.slim.min.js" -integrity "sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" -crossorigin "anonymous"
        script -src "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" -integrity "sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" -crossorigin "anonymous"
        script -src "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" -integrity "sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" -crossorigin "anonymous"
        title -Content "Incident Status Page"
        meta -httpequiv "refresh" -content "60"
    }
        
    body -Content {
        div -Class 'container' -Content {
            div -Class 'jumbotron' -Content {
                h1 -Class 'display-4' -Content "Incident Status (Service Now)"
                p -Class 'lead' -Content {
                    "ServiceNow integration with Azure Functions"
                }
            }
        }
        div -Class 'container' -Content {
            table -id "example" -Class 'table' -Content {
                thead -Class 'thead-dark' -Content {
                    tr -Content {
                        th -Content "Incident Number"
                        th -Content "Title"
                        th -Content "Location"
                        th -Content "impact"
                        th -Content "Status"
                    }
                }
                tbody -Content {
                    tr -Content {
                        $incidents.result | Where-Object { ($_.priority -ne '5 - Planning') -and ($_.priority -ne '4 - Low') } | . {
                            process {
                                $status = $($_.incident_state)
                                tr -Content {
                                    td -Content {
                                        $($_.number)
                                    }
                                    td -Content {
                                        $($_.short_description)
                                    }
                                    td -Content {
                                        $($_.location.display_value)
                                    }
                                    td -Content {
                                        $($_.impact -split "-").Trim()[1]
                                    }
                                    switch ($status) {
                                        "New" {
                                            td -Content { [string]::Concat('&#9995; New') }
                                        }
                                        "In Progress" {
                                            td -Content { [string]::Concat('&#9997; In Progress') }
                                        }
                                        "On Hold" {
                                            td -Content { [string]::Concat('&#10062; On Hold') }
                                        }
                                        "Closed" {
                                            td -Content { [string]::Concat('&#9989; Closed') }
                                        }
                                    }
                                }
                            }
                        }   
                    }
                }
            }
        }
    }
}


Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        Headers    = @{'content-type' = 'text/html' }
        StatusCode = [HttpStatusCode]::OK
        Body       = $html
    })