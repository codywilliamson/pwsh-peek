@{
    RootModule        = '.\DirectoryListing.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '7f3f0a1e-7aef-4b44-9e8c-9e61e5b7e6b1'
    Author            = 'Cody Williamson'
    CompanyName       = 'Personal'
    Copyright         = '(c) Cody Williamson'
    Description       = 'Modern, concise directory listing with human sizes and relative times; provides alias `peek`.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Get-DirectoryView',
        'Get-PeekAll',
        'Get-PeekAllRecurse',
        'Get-PeekFiles',
        'Get-PeekDirs',
        'Get-PeekAllSize',
        'Get-PeekAllNewest'
    )
    AliasesToExport   = @(
        'peek',
        'peek-all',
        'peek-all-recurse',
        'peek-files',
        'peek-dirs',
        'peek-all-size',
        'peek-all-newest',
        'pka', 'pkar', 'pkf', 'pkd', 'pkas', 'pkan'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    PrivateData       = @{ PSData = @{ Tags = @('listing', 'gci', 'ls', 'peek'); ProjectUri = ''; } }
}
