. ./settings.ps1
. ./common.ps1

$message_bus_assembly = $null


function Push-AzureMessageTopic {
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
    Begin {
        if(-not $message_bus_assembly){
            $message_bus_assembly = Load-MessageBusAssembly
        }
        $credentials = [Microsoft.ServiceBus.TokenProvider]::CreateSharedSecretTokenProvider($settings_name, $settings_key);
        $address = [Microsoft.ServiceBus.ServiceBusEnvironment]::CreateServiceUri('sb', $settings_namespace, "")
        $message_factory = [Microsoft.ServiceBus.Messaging.MessagingFactory]::Create($address, $credentials)
        $topic = $message_factory.CreateTopicClient($settings_topic)

        $i = 0;
    } 

    Process {
        $message_body = [string]$value
        $args = [System.IO.Stream] (new-object System.IO.MemoryStream -ArgumentList (, [System.Text.Encoding]::UTF8.GetBytes($message_body)))
        $message = new-object Microsoft.ServiceBus.Messaging.BrokeredMessage -ArgumentList ($args, $true)
        $message.ContentType = "text/plain"
        $message.Properties["MessageNumber"] = $i;
        if($length) {
            $message.Properties["Length"] = $length;
        }
        if ($metadata_script){
            $scriptblock_result = $metadata_script.Invoke("meta_$i");
            foreach($result in $scriptblock_result){
                foreach($k in $result.Keys){
                    $value = [string]$result[$k]
                    $message.Properties["extra_$k"] = "$value"
                }
            }
        }
        $topic.Send($message)
        $i += 1
    } 

    End {
        
    } 
} 


Get-ChildItem .| Push-AzureMessageTopic -metadata { @{Attributes=$_.Attributes ; TouchDate = $_.LastAccessTimeUtc  } }
# Get-ChildItem .| Push-AzureMessageTopic -metadata { @{Attributes=$_.Attributes } ; @{Another="Value"; TouchDate = $_.LastAccessTimeUtc } }
# Get-ChildItem .| Push-AzureMessageTopic -metadata { param([string]$t,$x)  @{Attributes=$_.Attributes; ix = "ates $t $x"; z=$x } ; @{Another="Value"; TouchDate = $_.LastAccessTimeUtc } }
# Get-ChildItem .| Push-AzureMessageTopic -metadata { param([string]$t)  @{ix = $t} }