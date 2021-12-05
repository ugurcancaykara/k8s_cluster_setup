module "cluster-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"


  name                   = count.index == 0 ? "master" : "worker"
  count                  = 3
  ami                    = var.ami_type
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh_key.id
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_web.id}"]
  subnet_id              = aws_subnet.test-subnet[keys(aws_subnet.test-subnet)[count.index % length(data.aws_availability_zones.available.names)]].id
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 16
    },
  ]
  tags = {
    Terraform   = "true"
    Environment = "test"
  }
  user_data = file("user_data.sh")
}

module "jump-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jump–instance"

  create_spot_instance = true
  spot_price           = "0.60"
  spot_type            = "persistent"

  ami                    = var.ami_type
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh_key.id
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_web.id}"]
  subnet_id              = aws_subnet.test-subnet[keys(aws_subnet.test-subnet)[0]].id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 16
    },
  ]
  tags = {
    Terraform   = "true"
    Environment = "test"
    Jump        = "true"
  }
  user_data = file("user_data.sh")
}


resource "aws_key_pair" "ssh_key" {
  key_name   = "test_key"
  public_key = file(var.ssh_public_key_path)
}