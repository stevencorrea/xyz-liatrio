# xyz-liatrio
A containerized cloud environment for potential client XYZ

### Getting Started
This project is a simple NodeJS app that exposes a REST endpoint.

This project assumes the following are set in the [Secrets of the repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets) and permissions to read these have been given to `workflows`:
* ACCESS_KEY (An AWS Access Key that has sufficent permissions to create, read and update resources)
* SECRET_KEY (The corresponding AWS Secret Key)

### Resources Created
On Terraform Apply of `init-remote-state`, Terraform will provision the following resources into AWS:

* Versioned, encrypted and private S3 bucket for State storage
* KMS key and alias used for Server Side Encryption (SSE) of S3 bucket
* DynamoDB table for [state locking and consistency checking](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
* Policies for the above resources

On Terraform Apply of `terraform`, Terraform will provision the following resources into AWS:

* A VPC consisting of 3 public and 3 private subnets (one for each availability zone)
* A NAT Gateway for the instances to access the internet
* An EKS cluster consisting of two node groups

### How to run
GitHub workflows contained inside of the `.github` directory execute on the following:

`init-remote-state`: change to .tf in `init-remote-state`

`terraform`: change to .tf in `terraform`

To build and run the server:
```shell
npm install && node start.js
```

To run tests against the server:
``` shell
jest test
```

### What's Running
Eventually, a node app will be served on the EKS cluster provisioned above...

### Cleanup
At the time of writing, manual teardown is required either by commenting out all resources in the terraform files or deleting via AWS console.

I believe I will build out a GH Actions workflow to teardown the environment. TODO: figure out on: trigger for destroy... Maybe a pipeline of pipelines?

#### Reference
Additional documentation is available in the [docs](https://github.com/stevencorrea/xyz-liatrio/tree/main/docs) directory.

There is also a [wiki page](https://github.com/stevencorrea/xyz-liatrio/wiki/XYZ-Cloud-App-Deployment-–-Notes) that contains some personal notes about the project.