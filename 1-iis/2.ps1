function Start-IisExpressFunc { 
    param($path, $port)

    if(-not $path){
        $path = "."
    }
    $path = (get-item $path).FullName

    if(-not $port){
        throw 'Missing port'
    }

    $program_files_path = get-content Env:\ProgramFiles
    if(@(get-childitem env:\programfiles*).Length -gt 1){
        $program_files_path = get-content 'Env:\ProgramFiles(x86)'
    }
    
    & "$program_files_path\IIS Express\iisexpress.exe" /port:$port /path:"$path"
}

# Start-IisExpressFunc 