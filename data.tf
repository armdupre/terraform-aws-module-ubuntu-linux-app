data "aws_region" "current" {}

data "aws_ami" "Ami" {
	owners = [ local.AmiOwner ]
	filter {
		name = "name"
		values = [ local.AmiName ]
    }
	most_recent = true
}