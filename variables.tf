variable "AmiName" {
	default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516"
	description = "AMI name used for deploying instances"
	type = string
}

variable "AmiOwner" {
	default = "099720109477"
	description = "Owner of AMI used for deploying instances"
	type = string
}

variable "Eth0SecurityGroupId" {
	description = "Id of the security group associated with first network interface"
	type = string
}

variable "Eth0SubnetId" {
	description = "Id of the subnet associated with the first network interface"
	type = string
}

variable "InstanceId" {
	default = "app"
	description = "Id of the instance of this module that ensures uniqueness"
	type = string
}

variable "InstanceName" {
	default = null
	description = "Custom instance name used to override the default automatically generated name"
	type = string
}

variable "InstanceType" {
	default = "c5.2xlarge"
	description = "Instance type of VM"
	type = string
	validation {
		condition = contains([	"m3.2xlarge",
								"m4.2xlarge", "m4.4xlarge",
								"m5.2xlarge", "m5.4xlarge", "m5.12xlarge",
								"c3.2xlarge", "c3.4xlarge", "c3.8xlarge",
								"c4.2xlarge", "c4.4xlarge", "c4.8xlarge",
								"c5.2xlarge", "c5.4xlarge", "c5.9xlarge", "c5.12xlarge",
								"c5n.2xlarge", "c5n.4xlarge", "c5n.9xlarge"
							], var.InstanceType)
		error_message = <<EOF
InstanceType must be one of the following types:
	m4.2xlarge, m4.4xlarge,
	m5.2xlarge, m5.4xlarge, m5.12xlarge,
	c3.2xlarge, c3.4xlarge, c3.8xlarge,
	c4.2xlarge, c4.4xlarge, c4.8xlarge,
	c5.2xlarge, c5.4xlarge, c5.9xlarge, c5.12xlarge,
	c5n.2xlarge, c5n.4xlarge, c5n.9xlarge
		EOF
	}
}

variable "SleepDelay" {
	default = "7m"
	description = "Time duration to delay to allow application to perform internal initialization required before use"
	type = string
}

variable "Tag" {
	default = "ubuntu"
	description = "App ID tag of application using the deployment"
	type = string
}

variable "UserEmailTag" {
	default = "terraform@example.com"
	description = "Email address tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserEmailTag) >= 14
		error_message = "UserEmailTag minimum length must be >= 14."
	}
}

variable "UserLoginTag" {
	default = "terraform"
	description = "Login ID tag of user creating the deployment"
	type = string
	validation {
		condition = length(var.UserLoginTag) >= 4
		error_message = "UserLoginTag minimum length must be >= 4."
	}
}

variable "UserProjectTag" {
	default = "module"
	description = "Project tag of user creating the deployment"
	type = string
}

variable "Version" {
	default = "2204-lts"
	description = "Versioning of the application using the deployment"
	type = string
}

variable "init_cli" {
	default = <<-EOF
#!/bin/bash -xe
snap list amazon-ssm-agent
    EOF
	type = string
}