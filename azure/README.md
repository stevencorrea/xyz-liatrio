# Initialize Azure

To connect GitHub Actions to Azure, we need to configure a few resources manually.
Replace anything with $syntax with the relevant value in your environment.
These instructions assume a macOS or Linux en

Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

Log in to Azure:

```bash
az login
```

Make a Service Principal for the runner to use:
```bash
az ad sp create-for-rbac --name "$myApp" --role Contributor \
--scopes /subscriptions/$subID/resourceGroups/$resourceGroupID \
--sdk-auth
```
Store the output of the Service Principal as AZURE_CREDENTIALS in GitHub Secrets

*** Ensure the following providers are enabled:
```bash
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.ContainerRegistry
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.ManagedIdentity
```

We should have enough to make some infrastructure! Delete the `null_resource` that's commented out in `main.tf` to trigger a run!

### Resources
[Instructions to set these resources up via portal, cli or powershell](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)
[Use GH Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux)
[Azure workflow Samples](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)
[Attaching a Container Registry to a Kubernetes Cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-attaching-a-container-registry-to-a-kubernetes-cluster)
[Service Principal for AKS and ACR Communication](https://stackoverflow.com/questions/53771773/azure-acr-how-to-assign-service-principle-through-terraform)
[AKS Cluster and attachment](https://jimferrari.com/2022/02/09/attach-azure-container-registry-to-azure-kubernetes-service-terraform/)
[Skip Provider Registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#skip_provider_registration)