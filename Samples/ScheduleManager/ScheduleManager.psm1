<#
.SYNOPSIS
    Creates a scheduled task.

.DESCRIPTION
    This function creates a scheduled task using the Task Scheduler.

.PARAMETER TaskName
    The name of the scheduled task.

.PARAMETER ActionPath
    The path to the executable or script that the task will run.

.PARAMETER TriggerTime
    The time at which the task will be triggered.

.EXAMPLE
    New-ScheduledTask -TaskName "MyTask" -ActionPath "C:\Path\To\MyScript.ps1" -TriggerTime "08:00AM"
#>
function New-ScheduledTask {
    param (
        [Parameter(Mandatory=$true)]
        [string]$TaskName,

        [Parameter(Mandatory=$true)]
        [string]$ActionPath,

        [Parameter(Mandatory=$true)]
        [datetime]$TriggerTime
    )

    # Create a new scheduled task action
    $action = New-ScheduledTaskAction -Execute $ActionPath

    # Create a new scheduled task trigger
    $trigger = New-ScheduledTaskTrigger -At $TriggerTime -Once

    # Register the new scheduled task
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $TaskName -User "SYSTEM" -RunLevel Highest
}

<#
.SYNOPSIS
    Updates an existing scheduled task.

.DESCRIPTION
    This function updates the trigger time of an existing scheduled task.

.PARAMETER TaskName
    The name of the scheduled task to update.

.PARAMETER NewTriggerTime
    The new time at which the task will be triggered.

.EXAMPLE
    Update-ScheduledTask -TaskName "MyTask" -NewTriggerTime "09:00AM"
#>
function Update-ScheduledTask {
    param (
        [Parameter(Mandatory=$true)]
        [string]$TaskName,

        [Parameter(Mandatory=$true)]
        [datetime]$NewTriggerTime
    )

    # Get the existing scheduled task
    $task = Get-ScheduledTask -TaskName $TaskName

    # Update the trigger time
    $trigger = New-ScheduledTaskTrigger -At $NewTriggerTime -Once
    Set-ScheduledTask -TaskName $TaskName -Trigger $trigger
}

<#
.SYNOPSIS
    Removes a scheduled task.

.DESCRIPTION
    This function removes a scheduled task using the Task Scheduler.

.PARAMETER TaskName
    The name of the scheduled task to remove.

.EXAMPLE
    Remove-ScheduledTask -TaskName "MyTask"
#>
function Remove-ScheduledTask {
    param (
        [Parameter(Mandatory=$true)]
        [string]$TaskName
    )

    # Unregister the scheduled task
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Export the functions to make them available when the module is imported
Export-ModuleMember -Function New-ScheduledTask, Update-ScheduledTask, Remove-ScheduledTask
