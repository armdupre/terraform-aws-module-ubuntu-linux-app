resource "aws_iam_instance_profile" "IamInstanceProfile" {
	name = local.IamInstanceProfileName
	role = aws_iam_role.IamRole.name
}

resource "aws_iam_role_policy_attachment" "IamRolePolicyAttachment" {
	role = aws_iam_role.IamRole.name
	policy_arn = aws_iam_policy.IamPolicy.arn
}

resource "aws_iam_role" "IamRole" {
	name = local.IamRoleName
	assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Principal": {
				"Service": "ec2.amazonaws.com"
			},
			"Effect": "Allow"
		}
	]
}
EOF
	path = "/"
}

resource "aws_iam_policy" "IamPolicy" {
	name = local.IamPolicyName
	description = "IamPolicy"
	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Action = [
					"ssm:UpdateInstanceInformation",
					"ssmmessages:CreateControlChannel",
					"ssmmessages:CreateDataChannel",
					"ssmmessages:OpenControlChannel",
					"ssmmessages:OpenDataChannel"
				]
				Effect = "Allow",
				Resource = "*"
			}
		]
	})
}