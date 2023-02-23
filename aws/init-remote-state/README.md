## Initialize Remote Resouces for TF State
We need to initialize an S3 bucket and DynamoDB Table for state and locking _before_ Terraform can leverage these resources. 

Therefore, we will use a seperate terraform file to achieve this and run this prior to main execution in the root of the project.

** At this time, this is a run-once bootstraping step. Please do not modify Terraform unless state is managed **

This creates the following:
Terraform State s3 bucket
KMS key with Alias (referenced by ../terraform for locking)
DynamoDB table

The above resources will need to be destroyed to rerun this script.

### Reference
[Stack Overflow](https://stackoverflow.com/questions/47913041/initial-setup-of-terraform-backend-using-terraform)