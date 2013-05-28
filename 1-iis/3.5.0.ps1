function Start-IisExpress { 
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [ValidateScript({ Test-Path $_ })]
        [string]$path, 
        [Parameter(Mandatory=$true, Position=1)]
        [ValidateRange(1,20000)]
        [int]$port,
        [Parameter(Mandatory=$false)]
        [Alias("c","clip")]
        [switch]$copy_to_clipboard
        )

    if(-not $path){
        $path = "."
    }
    $path = (get-item $path).FullName

    $program_files_path = get-content Env:\ProgramFiles
    if(@(get-childitem env:\programfiles*).Length -gt 1){
        $program_files_path = get-content 'Env:\ProgramFiles(x86)'
    }

    if ($copy_to_clipboard){
        Add-Type -Assembly PresentationCore
        $text_for_clipboard = "http://localhost:$port/"
        [Windows.Clipboard]::SetText($text_for_clipboard)
        Write-Host "Sent $text_for_clipboard to clipboard" -BackgroundColor Green
    }

    & "$program_files_path\IIS Express\iisexpress.exe" /port:$port /path:"$path"
    
}

Start-IisExpress "." 8181 -clip
Start-IisExpress "." 8181 -copy_to_clipboard
