# supreme-doodle

A demonstration of deploying a small infrastructure into AWS using Ansible.

3 t2.micro instances are booted, in a VPC. Each class of instance has its own subnet.

* bastion - allows ssh access to the other nodes
* web - 80/443 to internet - proxy for app 
* app - a backend app accessible via the web front-end

 
## Requirements

The following environment variables must be set:

* `AWS_ACCESS_KEY_ID` - Credentials for AWS
* `AWS_SECRET_KEY` - Credentials for AWS
* `AWS_REGION` - e.g. `us-east-2`

### NOTE

Certain versions of boto3 have an issue with newlines in the AWS_ environment variables, may require quotes:

    export AWS_SECRET_KEY='MY AWS SECRET KEY'


## How to deploy

    make prep
    make deploy

## Removal of resources created

    make clean

