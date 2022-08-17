data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "aws_org" {
  count = var.is_org_enabled ? 1 : 0
}
