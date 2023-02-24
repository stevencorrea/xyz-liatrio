# Secrets

| Platform | Use | Secrets
| ---------|-----|-----|
| [GitHub Actions](https://github.com/stevencorrea/xyz-liatrio/tree/main/.github/workflows) | Execute CI/CD |  |
| [Terraform Cloud](https://app.terraform.io/session) | Store and manage Terraform State | [TF_API_TOKEN](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#tokens) |
| [Azure](https://portal.azure.com) | Deploy resources to Azure Cloud | [AZURE_CREDENTIALS](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-static-site-github-actions?tabs=userlevel)
| **[ACR](https://azure.microsoft.com/en-us/products/container-registry/) | Azure Container Registry | [ACR_USERNAME](https://learn.microsoft.com/en-us/cli/azure/acr/credential?view=azure-cli-latest), [ACR_PASSWORD](https://learn.microsoft.com/en-us/cli/azure/acr/credential?view=azure-cli-latest)

** ACR Credentials can be retrieved after the initial Terraform run:
```bash
az acr credential show -n xyzacrliatrio
```