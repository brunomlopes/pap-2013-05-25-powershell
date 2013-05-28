function Start-CopyToClipboard{ 
    param(
        [Parameter(Mandatory=$false)]
        [Alias("c","clip")]
        [switch]$copy_to_clipboard
        )
    Write-Host "copy to clipboard is '$copy_to_clipboard'"
    
}

function Start-CopyToClipboardDefaultFalse{ 
    param(
        [Parameter(Mandatory=$false)]
        [Alias("c","clip")]
        [switch]$copy_to_clipboard = $false
        )
    Write-Host "copy to clipboard is '$copy_to_clipboard'"
    
}
function Start-CopyToClipboardDefaultTrue { 
    param(
        [Parameter(Mandatory=$false)]
        [Alias("c","clip")]
        [switch]$copy_to_clipboard = $true
        )
    Write-Host "copy to clipboard is '$copy_to_clipboard'"
    Write-Host "is present is '$($copy_to_clipboard.IsPresent)'"
    
}
Write-Host "Default behaviour" -BackgroundColor Black
Start-CopyToClipboard 
Start-CopyToClipboard -copy_to_clipboard
Write-Host "Value set to false" -BackgroundColor Black
Start-CopyToClipboardDefaultFalse
Start-CopyToClipboardDefaultFalse -copy_to_clipboard
Write-Host "Value set to true" -BackgroundColor Black
Start-CopyToClipboardDefaultTrue
Start-CopyToClipboardDefaultTrue -copy_to_clipboard
Start-CopyToClipboardDefaultTrue -copy_to_clipboard:$false