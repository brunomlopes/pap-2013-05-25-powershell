Import-Module .\module_1 -force

# get-help Start-IisExpress 
# get-help Push-AzureMessageTopic

echo "Este valor e o próximo são iguais: $a_random_variable"
Import-Module .\module_1 
echo "Import sem -force não re-avalia o módulo : $a_random_variable"

Import-Module .\module_1  -Force
echo "Um -force reavalia o modulo, e por conseguinte o valor muda: $a_random_variable"

Import-Module .\module_2.psm1 -Function "Start-IisExpress"

# get-help Start-IisExpress 
# get-help Push-AzureMessageTopic