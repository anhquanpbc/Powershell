<#
.SYNOPSIS
    Demonstrates the use of the CSVReader module.

.DESCRIPTION
    This script reads a CSV file, creates variables based on the headers, and adds them to a collection.

.EXAMPLE
    .\ExampleScript.ps1
#>

# Import the CSVReader module
Import-Module -Name .\CSVReader.psm1

# Path to the CSV file
$csvFilePath = "C:\path\to\file.csv"

# Read the CSV file and create variables
$csvCollection = Import-CsvAndCreateVariables -FilePath $csvFilePath

# Output the collection
$csvCollection

# Example usage of the created variables
foreach ($item in $csvCollection) {
    Write-Host "Item: $item"
}
