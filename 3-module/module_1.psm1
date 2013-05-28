    <#
.Synopsis
    Starts an IIS Express server (on module_1).
.Description
    Given a port and an option path, starts an IIS web application
.Parameter port
    An unused port 
.Parameter copy_to_clipboard
    Whether the url should be copied to the clipboard
    #>
function Start-IisExpress { 
    [CmdletBinding()]
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
    Write-Host "Start-IIsExpress code placeholder"
}

    <#
.Synopsis
    Sends an object to an Azure topic  (on module_1)
.Description
    Sends an object throught to an azure message topic.
    It allows for optionally adding more metadata to the message.
    #>
function Push-AzureMessageTopic {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [object]
        $value,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [int]
        $length,
        [Parameter(Mandatory=$false, Position=0)]
        [scriptblock]
        $metadata_script
        )
    Write-Host "Push-AzureMessageTopic code placeholder" 
} 

$a_random_variable = "This is a random value : $(Get-Random)"
Export-ModuleMember -Function Push-AzureMessageTopic,Start-IisExpress
Export-ModuleMember -Variable a_random_variable