./az-login.ps1

$rgName = 'teamResources'
$vnetName = 'internal-vmVMNic'
$publicIp = 'teamResources'
$bastionName = 'vnet-bastion'

az network bastion create  `
--name $bastionName `
--public-ip-address $publicIp `
--resource-group $rgName `
--vnet-name $vnetName