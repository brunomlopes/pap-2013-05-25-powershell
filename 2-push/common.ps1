function Load-MessageBusAssembly {
    $azure_servicesbus_assembly_path = "$($env:ProgramFiles)\Microsoft SDKs\Windows Azure\.NET SDK\v2.0\ref\Microsoft.ServiceBus.dll"
    if (-not (Test-Path $azure_servicesbus_assembly_path)){
        $azure_servicesbus_assembly_path = "$(gc 'env:ProgramFiles(x86)')\Microsoft SDKs\Windows Azure\.NET SDK\v2.0\ref\Microsoft.ServiceBus.dll"
    }
    [System.Reflection.Assembly]::LoadFile($azure_servicesbus_assembly_path)
}