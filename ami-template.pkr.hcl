# Defines the Packer configuration block and specifies required plugins
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon" # Specifies the source of the Amazon plugin
      version = ">= 1.0.0" # Ensures compatibility with Packer versions 1.0.0 and above
    }
  }
}

# Defines the Amazon Elastic Block Store (EBS)-backed AMI source
source "amazon-ebs" "shali" {
  region         = "us-east-1" # AWS region where the AMI will be created
  source_ami     = "ami-0e1bed4f06a3b463d" # Base AMI (Ubuntu 22.04), replace with a valid AMI ID
  instance_type  = "t2.micro" # Instance type used for building the image
  ssh_username   = "ubuntu" # SSH username for the base AMI
  communicator   = "ssh" # Specifies SSH as the communication method

  ami_name       = "packer-ubuntu-ami-{{timestamp}}" # Sets the AMI name with a timestamp
  ami_description = "Hardened AMI following CSI standards" # Provides a description for the AMI

  # Tags for identifying and organizing the AMI
  tags = {
    Name        = "shali-packer-image" # Name of the AMI
    Project     = "SHALI" # Project associated with the AMI
    Environment = "Dev" # Deployment environment (Development)
  }
}

# Build block to define provisioning steps
build {
  sources = ["source.amazon-ebs.shali"] # Uses the Amazon EBS source defined above

  # Executes a shell script for applying critical security standards
  provisioner "shell" {
    script = "scripts/001-critical-standards.sh" # Path to the shell script
  }

  # Executes a second shell script for non-critical configurations
  provisioner "shell" {
    script = "scripts/002-non-critical-standards.sh" # Path to the second script
  }
}