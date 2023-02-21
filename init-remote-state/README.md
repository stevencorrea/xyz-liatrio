## Initialize Remote Resouces for TF State
We need to initialize an S3 bucket and DynamoDB Table for state and locking _before_ Terraform can leverage these resources. 

Therefore, we will use a seperate terraform file to achieve this and run this prior to main execution in the root of the project.

### Reference
[Stack Overflow](https://stackoverflow.com/questions/47913041/initial-setup-of-terraform-backend-using-terraform)