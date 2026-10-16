@{
    RootModule        = 'Emily.Commands.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'b8f1c3a2-5d4e-4f6a-9b7c-2e1d0a3f4c5b'
    Author            = 'Emily Lockhart'
    Description       = 'My custom command aliases and functions'
    PowerShellVersion = '7.0'

    FunctionsToExport = @(
        'ls', 'l', 'lsd', 'lss', 'lst'
        'paths'
        'diff'
        'Format-Size'
        'dus'
    )
    AliasesToExport   = @('l', 'vi')
    CmdletsToExport   = @()
    VariablesToExport = @()
}
