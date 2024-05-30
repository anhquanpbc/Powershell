# Powershell

Below are several PowerShell function examples, from simple to complex:

### Basic Function
A simple function that takes no parameters and performs a basic task.

```powershell
function Get-Greeting {
    "Hello, World!"
}

# Call the function
Get-Greeting
```

### Function with Parameters
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

### Function with Default Parameter Values
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

### Function with CmdletBinding
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

### Function with Advanced Parameters
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

### Function with Error Handling
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

### Function with Pipeline Support
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

### Function with Splatting
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

### Summary
These examples demonstrate how to create PowerShell functions with increasing complexity. Starting from a simple function without parameters, we move to functions with parameters, default values, advanced attributes, error handling, pipeline support, and splatting. These techniques allow you to build robust and flexible PowerShell functions.
