# xyz-liatrio
A containerized cloud environment for potential client XYZ

## Quick Start
### Environment Initialization
* Clone or fork this repo
* Log into or create a Terraform Cloud account, [generate an API token]([TF_API_TOKEN](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#tokens)) and store it as TF_API_TOKEN in GitHub Secrets (Settings -> Secrets and Variables -> Actions)
* Log in to an [Azure account](https://portal.azure.com) or Create one and [follow these instructions](https://github.com/stevencorrea/xyz-liatrio/blob/main/azure/README.md)
* Store Service Principal credentials as AZURE_CREDENTIALS in GitHub Secrets
* Delete the `null_resource` in [azure/main.tf](https://github.com/stevencorrea/xyz-liatrio/blob/main/azure/main.tf#L26)
* Push/Merge the change and apply the Terraform
* Your environment is deployed 🎉

### Application
* Delete the comment in [app/server.js](https://github.com/stevencorrea/xyz-liatrio/blob/main/app/server.js#L4)
* Push/Merge the change and apply the Terraform
* Your app is deployed 🎉

### Operations
Should you need to acces your cluster, this command merges the config into `~/.kube/config`:
```bash
az aks get-credentials --resource-group xyz-liatrio --name xyz-aks-cluster
```

### Resource Provisioned
Terraform will provision the following resources into the Azure Resource group we import:
* An Azure Container Registry
* An Azure Kubernetes Cluster
* An Azure Role Assignment

### Effective Destruction
* Comment out all resources but the imported resource group at the top of `azure/main.tf`

### Total Destruction
* Install the [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) and log in: `terraform login`
* `terraform plan -destroy -out=destroy.tfplan` then `terraform apply destroy.tfplan`

Remember: 🐮 not 🐶 ...also, given that the resource group is imported, the [Azure environment will need to be reinitialized](https://github.com/stevencorrea/xyz-liatrio/blob/main/azure/README.md)


#### References
Additional documentation is available in the [docs](https://github.com/stevencorrea/xyz-liatrio/tree/main/docs) directory.

There is also a [wiki page](https://github.com/stevencorrea/xyz-liatrio/wiki/XYZ-Cloud-App-Deployment-–-Notes) that contains some personal notes about the project and development timeline.
