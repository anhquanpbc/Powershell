function Get-InstalledPrograms {
    [CmdletBinding()]
    param ()

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
    return $uniquePrograms
}

# Call the function to get the list of installed programs
$installedPrograms = Get-InstalledPrograms
# Display specific program details
foreach ($program in $installedPrograms) {
    if ($program.DisplayName -eq "Yarn") {
        Write-Host "DisplayName: $($program.DisplayName)"
        Write-Host "DisplayVersion: $($program.DisplayVersion)"
        Write-Host "Publisher: $($program.Publisher)"
        Write-Host "InstallDate: $($program.InstallDate)"
        Write-Host "Registry Key: $($program.PSPath)"
        Write-Host "----------------------------------------"
    }
}
