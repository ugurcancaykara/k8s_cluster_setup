
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



