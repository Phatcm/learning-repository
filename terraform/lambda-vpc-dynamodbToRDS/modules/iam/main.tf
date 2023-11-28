#IAM role
resource "aws_iam_role" "iam_role" {
  name = var.iamRoleName
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
  EOF
}

# resource "aws_iam_policy" "network_interface_policies" {
#   name = "network_interface_policies"
#   policy = <<EOF
#   {
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:PutLogEvents",
#                 "ec2:CreateNetworkInterface",
#                 "ec2:DescribeNetworkInterfaces",
#                 "ec2:DeleteNetworkInterface",
#                 "ec2:AssignPrivateIpAddresses",
#                 "ec2:UnassignPrivateIpAddresses"
#             ],
#             "Resource": "*"
#         }
#     ]
#     }   
#   }
#   EOF
# }

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  for_each = toset(var.policies_list)

  role       = aws_iam_role.iam_role.name
  policy_arn = each.value
}