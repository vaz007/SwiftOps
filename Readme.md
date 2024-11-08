## Introduction

This project provides an easy deployment solution for developers, aiming to set up a comprehensive infrastructure including VPC, ELB, NLB, and Kubernetes with integrated CI/CD. The Terraform configuration creates a robust VPC setup with both public and private subnets to securely host Kubernetes clusters and load balancers. Additionally, an S3 bucket is created to store the Terraform state file, and the AWS provider is configured to work with LocalStack for development. Together, these configurations deliver a streamlined, scalable infrastructure setup. 


## Prerequisites

To use this Terraform configuration, you will need the following:

1. Terraform installed on your machine.
2. Access to either LocalStack (for local development) or an AWS account (for production deployment).

## Provider Configuration
The `provider.tf` file configures the AWS provider with the following settings:

1. **Provider Source**: `hashicorp/aws`, version `~> 5.0`
2. **Region**: `us-east-1`
3. **Access Key and Secret Key**: `test` (for LocalStack)
4. **Skipping Credential Validation, Metadata API Check, and Account ID Check**: `true` (for LocalStack)
5. **Allowed Account IDs**: `000000000000` (for LocalStack)
6. **Endpoints**: Configured for various AWS services, pointing to the LocalStack environment (`http://localhost:4566`)

This provider configuration ensures that Terraform can interact with the LocalStack environment during development, and can be easily modified to work with a real AWS environment when deploying to production.



## S3 Bucket Configuration
The `s3.tf` file creates an S3 bucket with the following properties:

1. **Bucket Name**: `devops-directive-tf-state`
2. **Versioning**: Enabled, to keep track of changes to the Terraform state file

This S3 bucket will be used to store the Terraform state file, ensuring that the state is persisted and can be shared across multiple team members or environments.



### VPC
The VPC is created with a CIDR block of `10.0.0.0/16`, which provides a total of 65,536 IP addresses for your resources. The VPC also has DNS hostnames and DNS support enabled, which is necessary for certain AWS services like Kubernetes.

### Public Subnets
The configuration creates two public subnets, each in a different availability zone. The CIDR blocks for these subnets are `10.0.0.0/24` and `10.0.1.0/24`. Public subnets are used for resources that need to be accessible from the internet, such as load balancers and bastion hosts.

### Private Subnets
The configuration creates two private subnets, each in a different availability zone. The CIDR blocks for these subnets are `10.0.2.0/24` and `10.0.3.0/24`. Private subnets are used for resources that do not need direct internet access, such as your Kubernetes worker nodes.

### Internet Gateway
An Internet Gateway is created and attached to the VPC. This allows resources in the public subnets to communicate with the internet.

### NAT Gateways
Two NAT Gateways are created, each in a public subnet and associated with an Elastic IP address. These NAT Gateways allow resources in the private subnets to access the internet for tasks like software updates and downloads.

### Route Tables
The configuration creates a public route table and two private route tables:

1. **Public Route Table**: This route table has a default route (0.0.0.0/0) that points to the Internet Gateway, allowing public subnet resources to access the internet.
2. **Private Route Tables**: These route tables have a default route (0.0.0.0/0) that points to the respective NAT Gateway, allowing private subnet resources to access the internet.

The subnets are then associated with the appropriate route tables.

### Public Subnets
The configuration creates two public subnets, each in a different availability zone. The CIDR blocks for these subnets are `10.0.0.0/24` and `10.0.1.0/24`. Public subnets are used for resources that need to be accessible from the internet, such as load balancers and bastion hosts.

### Private Subnets
The configuration creates two private subnets, each in a different availability zone. The CIDR blocks for these subnets are `10.0.2.0/24` and `10.0.3.0/24`. Private subnets are used for resources that do not need direct internet access, such as your Kubernetes worker nodes.

### Internet Gateway
An Internet Gateway is created and attached to the VPC. This allows resources in the public subnets to communicate with the internet.

### NAT Gateways
Two NAT Gateways are created, each in a public subnet and associated with an Elastic IP address. These NAT Gateways allow resources in the private subnets to access the internet for tasks like software updates and downloads.

### Route Tables
The configuration creates a public route table and two private route tables:

1. **Public Route Table**: This route table has a default route (0.0.0.0/0) that points to the Internet Gateway, allowing public subnet resources to access the internet.
2. **Private Route Tables**: These route tables have a default route (0.0.0.0/0) that points to the respective NAT Gateway, allowing private subnet resources to access the internet.

The subnets are then associated with the appropriate route tables.
