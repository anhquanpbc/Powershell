function Get-InstalledPrograms {
    [CmdletBinding()]
    param (
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
# Get all programs
# Get-InstalledPrograms

# Get programs with a specific display name
# Get-InstalledPrograms -DisplayName "PowerToys"
