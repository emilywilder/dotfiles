[CmdletBinding()]
Param (
    $Dir = ".",             # stow directory
    $Target = "$Dir/..",    # target directory
    [Parameter(ParameterSetName='Stow')]
    [Switch]$Stow,
    [Parameter(ParameterSetName='Restow')]
    [Switch]$Restow,
    [Parameter(ParameterSetName='Delete')]
    [Switch]$Delete,
    [Parameter(Mandatory, ValueFromRemainingArguments, Position=0)]
    [String[]]$Packages     # package(s)
)

Write-Debug "Dir: ${Dir}"
Write-Debug "Target: ${Target}"
Write-Debug "Stow: ${Stow}"
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

function New-Link {
    param(
        [Parameter(Mandatory)]
        [String[]]
        $Path,

        [Parameter(Mandatory)]
        [String[]]
        $Value
    )

    Write-Debug "Linking $Path -> $Value"
    $ValueType = (Get-Item -Path $Value).GetType().Name
    Write-Debug "ValueType: $ValueType"
    $ItemType = switch ($ValueType)
    {
        "DirectoryInfo" { "Junction" }
        "FileInfo" { "HardLink" }
        Default {
            Write-Error "Unsupported type: $ValueType" -ErrorAction Stop
        }
    }
    Write-Debug "ItemType: $ItemType"
    Write-Debug "Resolved path of Value: $(Resolve-Path -Path $Value)"
    $res = New-Item -ItemType $ItemType -Path $Path -Value (Resolve-Path -Path $Value)
    "LINK: {0} => {1}" -f $res.FullName, $res.ResolvedTarget
}

function Install-Contents() {
    param(
        [Parameter(Mandatory)]
        [String[]]
        $Package,

        [Parameter(Mandatory)]
        [String[]]
        $StowPath,

        [Parameter(Mandatory)]
        [String[]]
        $TargetPath,

        [Parameter(Mandatory)]
        [String[]]
        $NodePath
    )

    $PackagePath = Join-Path $StowPath $Package $NodePath
    Write-Debug("Stowing contents of $PackagePath")
    Get-ChildItem -Path $PackagePath -Name | ForEach-Object {
        $PackageNodePath = Join-Path $PackagePath $_
        $TargetNodePath = Join-Path $TargetPath $NodePath $_
        Write-Debug "Checking $_"
        if (!(Test-Path $TargetNodePath)) {
            New-Link -Path $TargetNodePath -Value $PackageNodePath
        } else {
            if ((Test-Path $TargetNodePath -PathType Container) -and
                    ((Get-Item -Path $TargetNodePath).LinkTarget -ne (Resolve-Path -Path $PackageNodePath))) {
                Write-Debug "descend into $TargetNodePath"
                Install-Contents $Package $StowPath $TargetPath (Join-Path $NodePath $_)
            } else {
                Write-Error "$TargetNodePath already exists" -ErrorAction Stop
            }
        }
    }
}

function Install-Package() {
    param(
        [Parameter(Mandatory)]
        [String[]]
        $StowPath,

        [Parameter(Position = 0,
                Mandatory,
                ValueFromPipeline,
                ValueFromPipelineByPropertyName)]
        [String[]]
        $Package
    )

    process {
        $Package | ForEach-Object {
            Write-Debug("Planning stow of package $_...")
            if (Test-Path -Path (Join-Path $Dir $_) -PathType Container) {
                Install-Contents $_ $Dir $Target '.'
            } else {
                Write-Error "$_ is not a package."
            }
        }
    }
}

switch ($PSCmdlet.ParameterSetName)
{
    'Stow' {
        Write-Verbose "Using action Stow"
        Write-Debug "Planning stow of: $Packages ..."
        $Packages | Resolve-BournePath | Install-Package -StowPath $Dir
    }
    'Delete' {
        Write-Verbose "Using action Delete"
        throw [System.NotImplementedException] "Not implemented."
    }
    'Restow' {
        Write-Verbose "Using action Restow"
        throw [System.NotImplementedException] "Not implemented."
    }
    Default {
        Write-Error "No supported action specified." -ErrorAction Stop
    }
}
