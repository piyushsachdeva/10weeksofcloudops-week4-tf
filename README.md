
# Provisioning the Amazon EKS cluster using Terraform
This repository contains the terraform file code, which we can use to provision the Amazon EKS cluster.

## Architecture Diagram

![Architecture Diagram](https://cdn-images-1.medium.com/max/800/1*T5IRoSoiqT8qnYLUprsRUQ.png)

## Note and Links
We are currently on Blog 2

Blog 1: [Blog 1] (https://medium.com/p/71983375e550/edit) 

Blog 2: [Blog 2] (https://medium.com/p/aa96d9a00391/edit) 

Blog 3: [Blog 3] (https://medium.com/p/e604412e959f/edit)

Blog 4: [Blog 4] (https://medium.com/p/9e3d62e1c093/edit)

## Installation of Terraform
Follow the blog to Install the Terraform and another dependency.

1️⃣ Clone the repo

``` git clone https://github.com/chauhan-himani/kube_terraform.git ```

2️⃣ Let's install dependency to deploy the application

``` 
cd kube_terraform/ToDo-App/
terraform init
```

3️⃣ Edit the below file according to your configuration

`vim kube_terraform/ToDo-App/backend.tf`

add below code

```
terraform {
  backend "s3" {
    bucket = "S3-BUCKET-NAME"
    key    = "backend/TFSTATE-FILE.tfstate"
    region = "us-east-1"
    dynamodb_table = "DYNAMODB-TABLE-NAME"
  }
}
```

Let's set up the variable for our Infrastructure and create one file with the name of terraform.tfvars inside kube_terraform/ToDo-App/backend.tf and add the below conntent into that file.

```
REGION          = "us-east-1"
PROJECT_NAME    = "ToDo-App"
VPC_CIDR        = "10.0.0.0/16"
PUB_SUB1_CIDR   = "10.0.1.0/24"
PUB_SUB2_CIDR   = "10.0.2.0/24"
PRI_SUB3_CIDR   = "10.0.3.0/24"
PRI_SUB4_CIDR   = "10.0.4.0/24"
```

Please note that the above file is crucial for setting up the infrastructure, so pay close attention to the values you enter for each variable.

It's time to build the infrastructure

The below command will tell you what terraform is going to create.

`terraform plan`

Finally, HIT the below command to create the infrastructure...

`terraform apply`

type yes, and it will prompt you for permission or use --auto-approve in the command above.

This blog contains Three GitHub repository

➡️ [App Code] (https://github.com/chauhan-himani/AppCode)

➡️ [Terraform code] (https://github.com/chauhan-himani/kube_terraform)

➡️ [Manifest Repo] (https://github.com/chauhan-himani/kube_manifest)

If you want to learn how I created this project, please review my blogs. I've shared links to all the blogs above.👆

Thank you so much for reading my blog.
