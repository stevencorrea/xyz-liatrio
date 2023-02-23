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


[Instructions to set these resources up via portal, cli or powershell](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)
[Use GH Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux)
