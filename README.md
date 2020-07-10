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

## How to access resources
After the deploy complete, access information is printed on the terminal

## Removal of resources created

    make clean

# Areas for improvement/Follow-up questions
* How to make fault tolerant and H/A?
	
	This deployment could be more fault tolerant by splaying the resources into different AZs in the region, or moreso by deploying to different regions. The modules used support these features, and could be configured as such if desired. Additionally, ansible has modules to create elastic load-balancers.
	
* How to make this deployment more secure?

	There are various system-administration practices that can be applied to cloud instances. Obviously, the use of an ACME (Let's Encrypt) system would be step 1 in a real production deployment. Periodic replacement of the instances when newer images are available would ensure that we're not running with known vulnerabilities.
	
* How to keep up with changing demands?

	The deployment language (ansible) supports the creation of auto-scaling groups (ASG), which can be configured with launch configs.		