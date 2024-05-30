<#
.SYNOPSIS
    Retrieves a list of installed programs from the registry.

.DESCRIPTION
    This function retrieves a list of installed programs from both the 32-bit and 64-bit registry paths.
    It can filter the list based on a provided display name or list all installed programs if no display name is provided.

.PARAMETER DisplayName
    The display name to filter the list of installed programs. If not provided, all installed programs are listed.

.EXAMPLE
    Get-InstalledPrograms
    Retrieves and lists all installed programs.

.EXAMPLE
    Get-InstalledPrograms -DisplayName "Yarn"
    Retrieves and lists all installed programs with "Yarn" in their display name.

.NOTES
    Author: anhquanpbc
    Date: 2024-05-30
    Version: 1.0.0
#>
function Get-InstalledPrograms {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$DisplayName
    )

    # Retrieve the list of installed programs from the registry
    $programs32 = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName }

    $programs64 = Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" `
        -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName }

    # Combine the lists of programs from both registry paths
    $allPrograms = $programs32 + $programs64

    # Select important properties and add the registry key
    $allPrograms = $allPrograms | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, PSPath

    # Remove duplicate entries based on DisplayName
    $uniquePrograms = $allPrograms | Sort-Object DisplayName -Unique

    # Filter by DisplayName if the parameter is provided
    if ($PSCmdlet.ParameterSetName -eq '' -or $DisplayName) {
        $filteredPrograms = $uniquePrograms | Where-Object { $_.DisplayName -like "*$DisplayName*" }
    }
    else {
        $filteredPrograms = $uniquePrograms
    }

    # Return the filtered or complete list of programs
    return $filteredPrograms
}

# Example usage:
<##> Get-InstalledPrograms
<##> Get-InstalledPrograms -DisplayName "Yarn"
