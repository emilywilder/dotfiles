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

Write-Verbose "Using action '$($PSCmdlet.ParameterSetName)'"

throw [NotImplementedException] "Not meant for use in a live system."
