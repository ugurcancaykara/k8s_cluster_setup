#network
cidr_block           = "172.0.0.0/16"
ssh_public_key_path  = "pub_key_path"
ssh_private_key_path = "private_key_path"
instance_type        = "instance_type" #e.g -> t2.large
ami_type             = "ami_type"      #e.g -> ami-0c6ebbd55ab05f070 for eu-west-3
profile              = "profile"       # profile name of aws profile, to see -> cat ~/.aws/config \
region               = "region"        # region -> eu-west-1, eu-central-1 etc. 