packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

source "amazon-ebs" "shali" {
  region         = "us-east-1"
  source_ami     = "ami-0e1bed4f06a3b463d" # Replace with a valid Ubuntu 22.04 AMI ID
  instance_type  = "t2.micro"
  ssh_username   = "ubuntu"
  communicator   = "ssh"

  ami_name       = "packer-ubuntu-ami-{{timestamp}}"
  ami_description = "Hardened AMI following CSI standards"

  tags = {
    Name        = "shali-packer-image"
    Project     = "SHALI"
    Environment = "Dev"
  }
}

build {
  sources = ["source.amazon-ebs.shali"]

  provisioner "shell" {
  script = "scripts/001-critical-standards.sh"
}

provisioner "shell" {
  script = "scripts/002-non-critical-standards.sh"
}
}
