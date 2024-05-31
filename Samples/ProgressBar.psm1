<#
.SYNOPSIS
    Initializes the progress bar.

.DESCRIPTION
    This function initializes the progress bar with the specified activity name and total number of steps.
    It sets up global variables to track the activity, total steps, and current step.

.PARAMETER Activity
    The name of the activity being tracked by the progress bar.

.PARAMETER TotalSteps
    The total number of steps in the activity.

.EXAMPLE
    Initialize-ProgressBar -Activity "Copying Files" -TotalSteps 100
#>
function Initialize-ProgressBar {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Activity,
        
        [Parameter(Mandatory=$true)]
        [int]$TotalSteps
    )

    $script:ProgressBarActivity = $Activity
    $script:TotalSteps = $TotalSteps
    $script:CurrentStep = 0
}

<#
.SYNOPSIS
    Updates the progress bar.

.DESCRIPTION
    This function updates the progress bar with the current status. It increments the current step
    and calculates the percentage complete, then updates the progress bar display.

.PARAMETER Status
    The current status message to display in the progress bar.

.EXAMPLE
    Update-ProgressBar -Status "Step 50 of 100"
#>
function Update-ProgressBar {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Status
    )

    $script:CurrentStep++
    $percentComplete = ($script:CurrentStep / $script:TotalSteps) * 100
    Write-Progress -Activity $script:ProgressBarActivity -Status $Status -PercentComplete $percentComplete
}

<#
.SYNOPSIS
    Completes the progress bar.

.DESCRIPTION
    This function marks the progress bar as complete. It updates the progress bar display to show
    that the activity is finished.

.EXAMPLE
    Complete-ProgressBar
#>
function Complete-ProgressBar {
    Write-Progress -Activity $script:ProgressBarActivity -Completed -Status "Completed"
}

# Export the functions to make them available when the module is imported
Export-ModuleMember -Function Initialize-ProgressBar, Update-ProgressBar, Complete-ProgressBar
