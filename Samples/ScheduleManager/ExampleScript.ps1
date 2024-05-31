<#
.SYNOPSIS
    Demonstrates the use of the ScheduleManager module.

.DESCRIPTION
    This script creates, updates, and removes a scheduled task using the ScheduleManager module.

.EXAMPLE
    .\ExampleScheduleScript.ps1
#>

# Import the ScheduleManager module
Import-Module -Name .\ScheduleManager.psm1

# Create a new scheduled task
New-ScheduledTask -TaskName "MyTask" -ActionPath "C:\Path\To\MyScript.ps1" -TriggerTime (Get-Date -Hour 8 -Minute 0 -Second 0)

# Update the scheduled task
Update-ScheduledTask -TaskName "MyTask" -NewTriggerTime (Get-Date -Hour 9 -Minute 0 -Second 0)

# Remove the scheduled task
Remove-ScheduledTask -TaskName "MyTask"

Write-Host "Scheduled task operations completed successfully."
