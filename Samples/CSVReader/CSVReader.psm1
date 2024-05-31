<#
.SYNOPSIS
    Reads a CSV file and creates variables based on the headers.

.DESCRIPTION
    This function reads a CSV file and creates variables for each column based on the headers.
    It adds these variables to a collection.

.PARAMETER FilePath
    The path to the CSV file to read.

.EXAMPLE
    Import-CsvAndCreateVariables -FilePath "C:\path\to\file.csv"
#>
function Import-CsvAndCreateVariables {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    # Ensure the CSV file exists
    if (-not (Test-Path -Path $FilePath -PathType Leaf)) {
        throw "CSV file '$FilePath' does not exist."
    }

    # Read the CSV file into a collection
    $csvData = Import-Csv -Path $FilePath

    # Initialize an empty collection to store the variables
    $collection = @()

    # Loop through each row in the CSV data
    foreach ($row in $csvData) {
        # Initialize an empty hashtable to store the variables for this row
        $variables = @{}

        # Loop through each header (property) in the row
        foreach ($header in $row.PSObject.Properties.Name) {
            # Create a variable with the same name as the header and assign the value
            Set-Variable -Name $header -Value $row.$header -Scope Global

            # Add the variable to the hashtable
            $variables[$header] = $row.$header
        }

        # Add the hashtable to the collection
        $collection += $variables
    }

    # Return the collection
    return $collection
}

# Export the function to make it available when the module is imported
Export-ModuleMember -Function Import-CsvAndCreateVariables
