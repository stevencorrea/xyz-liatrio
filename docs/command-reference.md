# A list of helpful commands

### Create Service Principal
az ad sp create-for-rbac --name "sp1" --role Contributor \
--scopes /subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/resourceGroups/xyz-liatrio
--sdk-auth

### Terraform Import Resource Group
terraform import azurerm_resource_group.xyz-liatrio /subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/resourceGroups/xyz-liatrio

### Get ACR Credentials
az acr credential show -n xyzacrliatrio

### Get AKS Credentials
sudo az aks get-credentials --name xyz-aks-cluster --resource-group xyz-liatrio

### Get Enabled Providers Enabled for Subscription
az provider list --query "[].{Provider:namespace, Status:registrationState}" --out table

### Enable Provider
az provider register --namespace Microsoft.Batch