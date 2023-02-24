# Initialize Azure Environment

To connect GitHub Actions to Azure, we need to configure a few resources manually.
Replace anything with $syntax with the relevant value in your environment.
These instructions assume a macOS or Linux environment.

Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
Install the [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)

Log in to Azure:

```bash
az login
```

Create a Resource group:
```bash
az group create --name xyz-liatrio --location westus
```

Make a Service Principal for the runner to use. We assign the owner role as it creates a service principal for the eks cluster:
```bash
az ad sp create-for-rbac --name "sp-gh-az" --role Owner \
--scopes /subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/resourceGroups/xyz-liatrio \
--sdk-auth
```
Store the output of the Service Principal as AZURE_CREDENTIALS in GitHub Secrets

*** Enable the Azure providers using the commands below (only needs to be done once):
```bash
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.ContainerRegistry
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.ManagedIdentity
```

Set [Terraform Cloud up as an OAuth app](https://developer.hashicorp.com/terraform/cloud-docs/vcs/github) and give it access to the repo. Change the following settings:

Workspace Settings -> General

Execution Mode: Local

Workspace Settings -> Version Control

Apply Method: Auto apply

We now need to make a plan:

In a new branch, delete the `null_resource` that's commented out in `main.tf` and open a pull request.

We need to import the resource group above to deploy resources successfully:

```bash
cd azure
terraform login
terraform init
terraform import azurerm_resource_group.xyz-liatrio /subscriptions/b9009040-4a5e-47c8-833e-44bdbe7d3423/resourceGroups/xyz-liatrio
```

We can now deploy resources into our resource group. Merge the change and apply the terraform!

### Resources
[Instructions to set these resources up via portal, cli or powershell](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux)

[Use GH Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux)

[Azure workflow Samples](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)
[Attaching a Container Registry to a Kubernetes Cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage-attaching-a-container-registry-to-a-kubernetes-cluster)

[Service Principal for AKS and ACR Communication](https://stackoverflow.com/questions/53771773/azure-acr-how-to-assign-service-principle-through-terraform)

[AKS Cluster and attachment](https://jimferrari.com/2022/02/09/attach-azure-container-registry-to-azure-kubernetes-service-terraform/)

[Skip Provider Registration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#skip_provider_registration)