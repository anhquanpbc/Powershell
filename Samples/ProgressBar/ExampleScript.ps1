<#
.SYNOPSIS
    Demonstrates the use of the ProgressBar module.

.DESCRIPTION
    This script simulates a task by sleeping for a short duration in each iteration.
    It uses the ProgressBar module to display a progress bar for the task.

.EXAMPLE
    .\ExampleScript.ps1
#>

# Import the ProgressBar module
Import-Module -Name .\ProgressBar.psm1

# Initialize the progress bar
Initialize-ProgressBar -Activity "Copying Files" -TotalSteps 100

# Simulate a task with 100 steps
for ($i = 1; $i -le 100; $i++) {
    # Simulate work by sleeping for a short duration
    Start-Sleep -Milliseconds 50

    # Update the progress bar
    Update-ProgressBar -Status "Step $i of 100"
}

# Complete the progress bar
Complete-ProgressBar

Write-Host "Task completed successfully."
