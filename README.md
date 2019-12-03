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

[![Result](https://cdn.imgbin.com/23/17/19/imgbin-dreidel-hanukkah-accordion-h9LbzwFgKsDz6qF210BZg0i3w.jpg)](https://github.com/ChendrayanV/iAzServerless/blob/master/assets/Dreidel.mp4)
