# Update AKS to enable AAD.
az aks enable-addons --addons azure-keyvault-secrets-provider --name $aksName --resource-group $rgName

az keyvault create -n aks-openhack-team3-kv -g teamResources

az keyvault secret set --vault-name aks-openhack-team3-kv -n Environment --value Development
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlServer --value sqlservernom9737.database.windows.net
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlName --value mydrivingDB
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlUser --value sqladminnOm9737
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlPassword --value Password123!

$id = az aks show -g teamResources -n openhack-aks-challenge3-bis --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId -o tsv

# set policy to access keys in your key vault
az keyvault set-policy -n aks-openhack-team3-kv --key-permissions get --spn $id
# set policy to access secrets in your key vault
az keyvault set-policy -n aks-openhack-team3-kv --secret-permissions get --spn $id
# set policy to access certs in your key vault
az keyvault set-policy -n aks-openhack-team3-kv --certificate-permissions get --spn $id