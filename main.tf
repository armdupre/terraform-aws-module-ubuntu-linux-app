resource "aws_instance" "Instance" {
	disable_api_termination = local.InstanceDisableApiTermination
	instance_initiated_shutdown_behavior = local.InstanceInstanceInitiatedShutdownBehavior
	ami = data.aws_ami.Ami.image_id
	instance_type = local.InstanceType
	monitoring = local.InstanceMonitoring
	iam_instance_profile = aws_iam_instance_profile.IamInstanceProfile.id
	tags = {
		Name = local.InstanceName
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
	}
	user_data = local.init_cli
	network_interface {
		network_interface_id = aws_network_interface.Eth0.id
		device_index = "0"
	}
	root_block_device {
		delete_on_termination = local.InstanceEbsDeleteOnTermination
		volume_type = local.InstanceEbsVolumeType
	}
	timeouts {
		create = "9m"
		delete = "5m"
	}
}

resource "aws_network_interface" "Eth0" {
	description = local.Eth0Name
	source_dest_check = local.InterfaceSourceDestCheck
	subnet_id = local.Eth0SubnetId
	security_groups = [
		local.Eth0SecurityGroupId
	]
	tags = {
		Name = local.Eth0Name
		Owner = local.UserEmailTag
		Project = local.UserProjectTag
	}
}

resource "aws_eip" "Eth0ElasticIp" {
	domain = "vpc"
	network_interface = aws_network_interface.Eth0.id
	depends_on = [
		aws_instance.Instance
	]
}

resource "time_sleep" "SleepDelay" {
	create_duration = local.SleepDelay
	depends_on = [
		aws_instance.Instance
	]
}