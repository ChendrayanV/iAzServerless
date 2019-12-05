# Input bindings are passed in via param block.
param($Timer)

$currentTime = (Get-Date)
Write-Host "Hello at $currentTime"

Write-Host "Hello at $($currentTime.AddMinutes(1))"


# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
