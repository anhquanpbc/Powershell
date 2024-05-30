<#
.SYNOPSIS
    Writes a log entry to a specified log file and optionally to the console.

.DESCRIPTION
    This function writes a log entry to a specified log file with a timestamp, log level, and message.
    It creates the log directory if it does not exist. It also allows writing the log entry to the console.

.PARAMETER Message
    The log message to write. This parameter is mandatory.

.PARAMETER Level
    The log level for the message. Valid values are "INFO", "WARNING", and "ERROR". The default is "INFO".

.PARAMETER LogFilePath
    The path to the log file. The default is "C:\Logs\script.log".

.EXAMPLE
    Write-Log -Message "This is an informational message."
    This writes an informational message to the default log file and console.

.EXAMPLE
    Write-Log -Message "This is a warning message." -Level "WARNING"
    This writes a warning message to the default log file and console.

.EXAMPLE
    Write-Log -Message "This is an error message." -Level "ERROR" -LogFilePath "C:\Logs\custom_log.log"
    This writes an error message to a custom log file and console.

.NOTES
    Author: anhquanpbc
    Date: 2024-05-30
    Version: 1.0.0
#>
function Write-Log {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [Parameter(Mandatory = $false)]
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO",

        [Parameter(Mandatory = $false)]
        [string]$LogFilePath = "C:\Logs\script.log"
    )

    # Create the log directory if it does not exist
    $logDirectory = [System.IO.Path]::GetDirectoryName($LogFilePath)
    if (-not (Test-Path -Path $logDirectory)) {
        New-Item -Path $logDirectory -ItemType Directory -Force
    }

    # Format the log entry
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp [$Level] - $Message"

    # Write the log entry to the log file
    Add-Content -Path $LogFilePath -Value $logEntry

    # Optionally, also write the log entry to the console
    Write-Host $logEntry
}

# Example usage:
<##> Write-Log -Message "This is an informational message."
<##> Write-Log -Message "This is a warning message." -Level "WARNING"
<##> Write-Log -Message "This is an error message." -Level "ERROR" -LogFilePath "C:\Logs\custom_log.log"
