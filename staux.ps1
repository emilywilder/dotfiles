[CmdletBinding()]
Param (
    $Dir = ".",
    $Target = "$Dir/..",
    [Parameter(ParameterSetName='Restow')]
    [Switch]$Restow,
    [Parameter(ParameterSetName='Delete')]
    [Switch]$Delete,
    [Parameter(Mandatory, ValueFromRemainingArguments, Position=0)]
    [String[]]$Packages
)

Write-Debug "Dir: ${Dir}"
Write-Debug "Target: ${Target}"
Write-Debug "Restow: ${Restow}"
Write-Debug "Delete: ${Delete}"
Write-Debug "Packages: ${Packages}"

switch ($PSCmdlet.ParameterSetName)
{
    'Restow' {
        Write-Verbose "Using action Restow"
        throw [System.NotImplementedException] "Not implemented."
    }
    'Delete' {
        Write-Verbose "Using action Delete"
        throw [System.NotImplementedException] "Not implemented."
    }
    Default {
        Write-Error "No supported action specified." -ErrorAction Stop
    }
}
