# xyz-liatrio
A containerized cloud environment for potential client XYZ


## Setup
This project leverages platforms that require integration via secrets. Please ensure the following are configured for your environment prior to _application_ deploy: 

| Platform | Use | Secrets
| ---------|-----|-----|
| [GitHub Actions](https://github.com/stevencorrea/xyz-liatrio/tree/main/.github/workflows) | Execute CI/CD | NA |
| [Terraform Cloud](https://app.terraform.io/session) | Store and manage Terraform State | [TF_API_TOKEN](https://developer.hashicorp.com/terraform/cloud-docs/users-teams-organizations/users#tokens) |
| [Azure](https://portal.azure.com) | Deploy resources to Azure Cloud | [AZURE_CREDENTIALS](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-static-site-github-actions?tabs=userlevel)
| [ACR](https://azure.microsoft.com/en-us/products/container-registry/) | Known after First Run | [ACR_USERNAME](https://learn.microsoft.com/en-us/cli/azure/acr/credential?view=azure-cli-latest), [ACR_PASSWORD](https://learn.microsoft.com/en-us/cli/azure/acr/credential?view=azure-cli-latest)


### Getting Started
This project is a simple NodeJS app that exposes a REST endpoint.

### Architecture

![XYZ High Level Architecture](https://user-images.githubusercontent.com/7317502/221084129-0aae27c6-0188-46b6-a70b-c32897193b39.png)

#### Reference
Additional documentation is available in the [docs](https://github.com/stevencorrea/xyz-liatrio/tree/main/docs) directory.

There is also a [wiki page](https://github.com/stevencorrea/xyz-liatrio/wiki/XYZ-Cloud-App-Deployment-–-Notes) that contains some personal notes about the project.
