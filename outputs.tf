output "instance_id" {
  value = join("", aws_instance.this.*.id)
}

output "instance_arn" {
  value = join("", aws_instance.this.*.arn)
}

output "instance_name" {
  value = "${var.name}${var.instance_suffix}"
}

output "security_group_name" {
  value = join("", aws_security_group.this.*.name)
}

output "security_group_id" {
  value = join("", aws_security_group.this.*.id)
}

output "security_group_arn" {
  value = join("", aws_security_group.this.*.arn)
}

output "instance_profile_name" {
  value = join("", aws_iam_instance_profile.this.*.name)
}

output "instance_profile_id" {
  value = join("", aws_iam_instance_profile.this.*.id)
}

output "instance_profile_arn" {
  value = join("", aws_iam_instance_profile.this.*.arn)
}

output "role_name" {
  value = join("", aws_iam_role.this.*.name)
}

output "role_id" {
  value = join("", aws_iam_role.this.*.id)
}

output "role_arn" {
  value = join("", aws_iam_role.this.*.arn)
}

output "sdm_node_id" {
  value = join("", sdm_node.this.*.id)
}