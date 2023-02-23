# Deploy to Azure

To connect GitHub Actions to Azure, we need to configure a few resources manually.

Grab the Azure CLI:
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Create a new App:

```bash
az ad app create --display-name myApp
```

Create a service principal using the 'id' of the previous command output as the 'id' flag:

```bash
az ad sp create --id $uniq-id
```

Create a resource group for the app:

```bash
az group create --name xyz-resource-group --location westus
```

Assign the service principal a role assignment. We'll want to give this owner since we're going to have it provision AKS clusters:

```bash
az role assignment create --role owner --subscription $id-from-first-command --assignee-object-id  $sp-id-from-second-command --assignee-principal-type ServicePrincipal --scope /subscriptions/$subscriptionId/resourceGroups/$name-from-resource-group
```

clientID = $appID from previous command
subscriptionID = $id-from-first-command (entered at --subscription at above command)
tenantID = $homeTenantId from first command

Continue the process for setting up Authentication between Azure and GitHub Actions. I leveraged OpenID Connect with the following:

Organization: (repo owner) stevencorrea
Repository: xyz-liatrio
Entity type: Branch
Based on Selection: main

Provide the aforementioned clientID, subscriptionID and tenantID to GH Actions as Secrets as documented:

GitHub Secret	Azure Active Directory Application
AZURE_CLIENT_ID	Application (client) ID
AZURE_TENANT_ID	Directory (tenant) ID
AZURE_SUBSCRIPTION_ID	Subscription ID

Make a SP for the runner to use:
az ad sp create-for-rbac --name "myApp" --role owner \
--scopes /subscriptions/$subID/resourceGroups/xyz-liatrio \
--sdk-auth


*** Ensure the compute provider is enabled. 
I was not able to get passed Terraform trying to register all providers using the service principal credentials. Attempted as owner and contributor
More on that here: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#skip_provider_registration

import the resource group we made earlier:
```bash
terraform import azurerm_resource_group.xyz-liatrio /subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/resourceGroups/xyz-liatrio
```

### Resources
[Instructions to set these resources up via portal, cli or powershell](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)
[Use GH Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux)
[Azure workflow Samples](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)

[Attaching a Container Registry to a Kubernetes Cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-attaching-a-container-registry-to-a-kubernetes-cluster)
[Service Principal for AKS and ACR Communication](https://stackoverflow.com/questions/53771773/azure-acr-how-to-assign-service-principle-through-terraform)
[AKS Cluster and attachment](https://jimferrari.com/2022/02/09/attach-azure-container-registry-to-azure-kubernetes-service-terraform/)
