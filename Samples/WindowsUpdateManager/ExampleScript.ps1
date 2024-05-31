<#
.SYNOPSIS
    Demonstrates the use of the WindowsUpdateManager module.

.DESCRIPTION
    This script checks for, downloads, and installs Windows updates using the WindowsUpdateManager module.

.EXAMPLE
    .\ExampleUpdateScript.ps1
#>

# Import the WindowsUpdateManager module
Import-Module -Name .\WindowsUpdateManager.psm1

# Check for available updates
$updates = Check-WindowsUpdates

# Download the updates
Download-WindowsUpdates -Updates $updates

# Install the updates
Install-WindowsUpdates -Updates $updates

Write-Host "Windows update operations completed successfully."
