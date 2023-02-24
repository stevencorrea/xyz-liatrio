# xyz-liatrio
A containerized cloud environment for potential client XYZ

## Quick Start
### Environment Initialization
* Clone or fork this repo
* Log into or create a Terraform Cloud account, [generate an API token]([TF_API_TOKEN](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#tokens)) and store it as TF_API_TOKEN in GitHub Secrets (Settings -> Secrets and Variables -> Actions)
* Log in to an [Azure account](https://portal.azure.com) or Create one and [follow these instructions]()
* Store Service Principal credentials as AZURE_CREDENTIALS in GitHub Secrets
* Delete the `null_resource` in [azure/main.tf](https://github.com/stevencorrea/xyz-liatrio/blob/main/azure/main.tf#L26)
* Push/Merge the change
* Your environment is deployed (~12min) 🎉

### Application
* Delete the comment in [app/server.js](https://github.com/stevencorrea/xyz-liatrio/blob/main/app/server.js#L4)
* Push/Merge the change
* Your app is deployed (~3min) 🎉

### Destruction
* Install the [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) and log in: `terraform login`
* `terraform plan -destroy -out=destroy.tfplan` then `terraform apply destroy.tfplan`
Remember: 🐮 not 🐶

#### Reference
Additional documentation is available in the [docs](https://github.com/stevencorrea/xyz-liatrio/tree/main/docs) directory.

There is also a [wiki page](https://github.com/stevencorrea/xyz-liatrio/wiki/XYZ-Cloud-App-Deployment-–-Notes) that contains some personal notes about the project and development timeline.
