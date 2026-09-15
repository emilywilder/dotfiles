[CmdletBinding()]
Param (
    $Dir = ".",
    $Target = "$Dir/..",
    [Parameter(ParameterSetName='Restaux')]
    [Switch]$Restaux,
    [Parameter(ParameterSetName='Delete')]
    [Switch]$Delete,
    [Parameter(Mandatory, ValueFromRemainingArguments, Position=0)]
    [String[]]$Packages
)

Write-Debug "Dir: ${Dir}"
Write-Debug "Target: ${Target}"
Write-Debug "Restaux: ${Restaux}"
Write-Debug "Delete: ${Delete}"
Write-Debug "Packages: ${Packages}"

throw [NotImplementedException] "Not meant for use in a live system."
