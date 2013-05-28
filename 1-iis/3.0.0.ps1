function Start-IisExpressCmdLet {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, Position=1)]
        [ValidateScript({ Test-Path $_ })]
        $path, 
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateRange(1,20000)]
        [int]
        $port)

    if(-not $path){
        $path = "."
    }
    $path = (get-item $path).FullName

    $program_files_path = get-content Env:\ProgramFiles
    if(@(get-childitem env:\programfiles*).Length -gt 1){
        $program_files_path = get-content 'Env:\ProgramFiles(x86)'
    }
    
    & "$program_files_path\IIS Express\iisexpress.exe" /port:$port /path:"$path"
}

# Start-IisExpressFunc -?
# Start-IisExpressCmdLet -?
# Start-IisExpressCmdLet "non-existing-path" 8181
# Start-IisExpressCmdLet "." 8181
# Start-IisExpressCmdLet 8181