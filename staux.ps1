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

function Resolve-BournePath {
    <#
    .SYNOPSIS
        Resolve Bourne style paths and wildcards to their Powershell equivalents.
    .DESCRIPTION
        Given an array of paths, treat wildcard entries as Bourne shell compatible globs.
        The supported wildcard entries are translated as:
            '*'     All non-hidden files in the current directory
            '*/'    All non-hidden directories in the current directory

        Wildcard entries can be part of an array of other entries and will expand the output array.
        For example, @( 'file1', '*' ) could map to @( 'file1', 'file1', 'file2', 'file3' ) given the appropriate
        directory structure.

        Paths can be given through the named parameter `Path` or supplied through the pipeline.
    .EXAMPLE
        Given the current working directory listing of

            Mode  Name
            ----  ----
            d---- dir1
            d---- dir2
            -a--- .hiddenFile
            -a--- file1
            -a--- file2

        `Resolve-BournePath -Path '*'` would output `@( 'dir1', 'dir2', 'file1', 'file2' )` while
        `Resolve-BournePath -Path '*/'` would output `@( 'dir1', 'dir2' )`
        `@( '*/' ) | Resolve-BournePath` also functions the same.

        `Resolve-BournePath -Path 'file1', '*/', 'dir2'` would output @( 'file1', 'dir1', 'dir2', 'dir2' )
    #>
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    param (
    # Path or wildcard to process
        [Parameter(Position = 0,
                ParameterSetName = "Path",
                Mandatory = $true,
                ValueFromPipeline = $true,
                ValueFromPipelineByPropertyName = $true)]
        [String[]]
        $Path
    )

    process {
        $Path | ForEach-Object {
            # conform to Bourne-style globbing for * and */
            # powershell doesn't consider filenames beginning with '.' to be hidden,
            # nor does it translate */ as directories
            if ($_ -eq '*/') {
                Get-ChildItem -Path . -Directory -Exclude .* -Name
            } elseif ($_ -eq '*') {
                Get-ChildItem -Path . -Exclude .* -Name
            } else {
                $_
            }
        }
    }
}

function Install-Package() {
    param(
        [Parameter(Position = 0,
                ParameterSetName = "Package",
                Mandatory = $true,
                ValueFromPipeline = $true,
                ValueFromPipelineByPropertyName = $true)]
        [String[]]
        $Package
    )

    process {
        $Package | % {
            Write-Debug("Planning stow of package $_...")
        }
    }
}

switch ($PSCmdlet.ParameterSetName)
{
    'Restow' {
        Write-Verbose "Using action Restow"
        Write-Debug "Planning stow of: $Packages ..."
        $Packages | Resolve-BournePath | Install-Package
    }
    'Delete' {
        Write-Verbose "Using action Delete"
        throw [System.NotImplementedException] "Not implemented."
    }
    Default {
        Write-Error "No supported action specified." -ErrorAction Stop
    }
}
