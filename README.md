# Powershell

### Installing PowerShell 7

PowerShell 7 can be installed on Windows, macOS, and Linux. Below are the steps for each platform.

#### On Windows

1. **Download the MSI package**:
   - Visit the [PowerShell GitHub releases page](https://github.com/PowerShell/PowerShell/releases).
   - Download the MSI package for the latest PowerShell release.

2. **Install PowerShell 7**:
   - Run the downloaded MSI package and follow the installation wizard.

3. **Verify the installation**:
   - Open a new PowerShell or Command Prompt window.
   - Type `pwsh` and press Enter. This will start PowerShell 7.

#### On macOS

1. **Install Homebrew** (if not already installed):
   - Open the Terminal and run:

     ```sh
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

2. **Install PowerShell 7**:
   - Run the following command in the Terminal:

     ```sh
     brew install --cask powershell
     ```

3. **Verify the installation**:
   - Type `pwsh` in the Terminal and press Enter to start PowerShell 7.

#### On Linux

For Linux distributions, use the appropriate package manager.

**On Ubuntu/Debian**:

1. **Download the Microsoft repository GPG keys** and register the Microsoft repository:

   ```sh
   wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
   sudo dpkg -i packages-microsoft-prod.deb
   ```

2. **Update the package list and install PowerShell**:

   ```sh
   sudo apt-get update
   sudo apt-get install -y powershell
   ```

3. **Start PowerShell**:

   ```sh
   pwsh
   ```

**On CentOS/RHEL**:

1. **Register the Microsoft repository**:

   ```sh
   sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
   curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
   ```

2. **Install PowerShell**:

   ```sh
   sudo yum install -y powershell
   ```

3. **Start PowerShell**:

   ```sh
   pwsh
   ```

### Running a PowerShell Script

1. **Write your PowerShell script**:
   - Save your script with a `.ps1` extension, for example `MyScript.ps1`.

2. **Run the script in PowerShell 7**:
   - Open PowerShell 7 by typing `pwsh` in your command line (Windows, macOS, or Linux terminal).
   - Navigate to the directory containing your script using `cd` command.
   - Run the script by typing `.\MyScript.ps1`.

#### Example

Let's create a simple script that outputs "Hello, World!".

1. **Create a script file**:
   - Open your preferred text editor and create a file named `HelloWorld.ps1` with the following content:

     ```powershell
     Write-Host "Hello, World!"
     ```

2. **Save the file** and navigate to its directory in your terminal.

3. **Run the script**:

   ```sh
   pwsh
   cd path\to\your\script
   .\HelloWorld.ps1
   ```

The terminal should display:

```sh
Hello, World!
```

By following these steps, you can install PowerShell 7 on various platforms and run PowerShell scripts easily.

### Below are several PowerShell function examples, from simple to complex:
#### Block comments
Designated by the symbols <# and #>, are specifically used in PowerShell to document functions.
```powershell
<#
.SYNOPSIS
    [A brief description of what the script does.]

.DESCRIPTION
    [A detailed description of the script, including how it works and its intended use.]

.PARAMETER [Parameter_Name]
    [Description of this parameter.]

.EXAMPLE
    [Example of how to use the script.]

.NOTES
    Author: [Your Name]
    Date: [Creation Date]
    Version: [Script Version]

.LINK
    [Link to documentation or online source, if any.]

#>

```
#### Basic Function
A simple function that takes no parameters and performs a basic task.

```powershell
function Get-Greeting {
    "Hello, World!"
}

# Call the function
Get-Greeting
```

#### Function with Parameters
A function that accepts parameters and uses them within its logic.

```powershell
function Get-Greeting {
    Param (
        [string]$Name
    )
    "Hello, $Name!"
}

# Call the function with a parameter
Get-Greeting -Name "Alice"
```

#### Function with Default Parameter Values
A function that provides default values for its parameters.

```powershell
function Get-Greeting {
    Param (
        [string]$Name = "World"
    )
    "Hello, $Name!"
}

# Call the function with and without a parameter
Get-Greeting -Name "Alice"
Get-Greeting
```

#### Function with CmdletBinding
A function that uses CmdletBinding to support common parameters like `-Verbose` and `-ErrorAction`.

```powershell
function Get-Greeting {
    [CmdletBinding()]
    Param (
        [string]$Name = "World"
    )
    Write-Verbose "Generating greeting message for $Name"
    "Hello, $Name!"
}

# Call the function with the -Verbose common parameter
Get-Greeting -Name "Alice" -Verbose
```

#### Function with Advanced Parameters
A function that uses advanced parameter attributes such as `Mandatory`, `Alias`, and `ValidateSet`.

```powershell
function Get-Greeting {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [Alias("n")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateSet("Morning", "Afternoon", "Evening")]
        [string]$TimeOfDay = "Morning"
    )
    "Good $TimeOfDay, $Name!"
}

# Call the function with different parameters
Get-Greeting -Name "Alice" -TimeOfDay "Afternoon"
```

#### Function with Error Handling
A function that includes error handling using try/catch blocks.

```powershell
function Get-Division {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [int]$Dividend,

        [Parameter(Mandatory=$true)]
        [int]$Divisor
    )
    try {
        $Result = $Dividend / $Divisor
        "Result: $Result"
    }
    catch {
        Write-Warning "An error occurred: $_"
    }
}

# Call the function with valid and invalid input
Get-Division -Dividend 10 -Divisor 2
Get-Division -Dividend 10 -Divisor 0
```

#### Function with Pipeline Support
A function that supports pipeline input.

```powershell
function Get-Square {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [int]$Number
    )
    Process {
        $Number * $Number
    }
}

# Call the function with pipeline input
1..5 | Get-Square
```

#### Function with Splatting
A function that uses splatting to pass parameters to another cmdlet.

```powershell
function Get-LocalGroup {
    [CmdletBinding()]
    Param (
        [Alias('cn')]
        [String[]]$ComputerName = $Env:COMPUTERNAME,

        [String]$AccountName,

        [System.Management.Automation.PsCredential]$Credential
    )

    $Splatting = @{
        Class     = "Win32_Group"
        Namespace = "root\cimv2"
        Filter    = "LocalAccount='$True'"
    }

    if ($PSBoundParameters['Credential']) {
        $Splatting.Credential = $Credential
    }

    foreach ($Computer in $ComputerName) {
        try {
            Write-Verbose -Message "[PROCESS] ComputerName: $Computer"
            Get-WmiObject @Splatting -ComputerName $Computer | Select-Object -Property Name, Caption, Status, SID, SIDType, Domain, Description
        }
        catch {
            Write-Warning -Message "[PROCESS] Issue connecting to $Computer"
        }
    }
}

# Call the function with splatting
$Params = @{
    ComputerName = "Localhost"
    AccountName  = "Admin"
}

Get-LocalGroup @Params
```

#### Summary
These examples demonstrate how to create PowerShell functions with increasing complexity. Starting from a simple function without parameters, we move to functions with parameters, default values, advanced attributes, error handling, pipeline support, and splatting. These techniques allow you to build robust and flexible PowerShell functions.
