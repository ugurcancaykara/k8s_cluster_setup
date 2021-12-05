
<!-- ABOUT THE Notes -->
## About The Notes

Change vars.tfvars according to your requests.

Then

### Run

- Terraform init
- Terraform plan -out 'tfplan' -var-file vars.tfvars
- Terraform apply 'tfplan'

### For Destroy
- Terraform destroy -var-file vars.tfvars

### Dones
- add vpc, internet gateway, security group, public subnet, route table, ec2, 

### For next improvements
- add a private subnet and make it accessible to internet via nat gateway which will be used by resources that don't need to be publicly accessible.
- add network access list to make subnets more secure
- add direct  connect via vpn gateway to reach out private subnet from on preme resources (developer laptop etc) -> VPN Gateway
- add site to site vpn connection with using customer gateway
- add vpc endpoints to create a direct connection between the vpc and other aws services like cloudwatch, s3 (without requiring access over the internet) -> make a demo
- integrate vpc flow logs and capture information about ip traffic to and from network interfaces in our vpc
- add another vpc in another region and create a vpc peering between existing one and newly created one. And manage the same infra in it.
- apply Private Link -> provide a private link with other vpc or aws services -> make a demo