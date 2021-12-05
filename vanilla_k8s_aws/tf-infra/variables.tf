variable "ssh_public_key_path" {
  type        = string
  description = "Path of ssh key"

}

variable "ssh_private_key_path" {
  type        = string
  description = "Path of ssh key"

}

variable "region" {
  type        = string
  description = "Region that you want to provision the resources"
}
variable "profile" {
  type        = string
  description = "AWS profile name"
}


variable "cidr_block" {
  type        = string
  description = "Range of CIDR"
}

variable "instance_type" {
  type        = string
  description = "Type of Instance"
}

variable "ami_type" {
  type        = string
  description = "Type of Instance Image (AMI)"
}


variable "az_number" {
  # Assign a number to each AZ letter used in our configuration
  default = {
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
    # and so on, up to n = 14 if that many letters are assigned
  }
}