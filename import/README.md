# Import

# https://github.com/GoogleCloudPlatform/terraformer

~~~
brew install terraformer
mkdir import ; cd import ; echo 'provider "aws" {}' > init.tf ; terraform init
~~~

e.g.
~~~
terraformer import aws --resources=alb,ec2_instance,eip,ebs,igw,nat,rds,route_table,sg,subnet,vpc,vpc_peering --regions=ap-northeast-1 --profile=private
~~~