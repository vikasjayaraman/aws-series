## Root Account Alerts StackSet for Organizational Member Accounts ##
resource "aws_cloudformation_stack_set" "root_account_alerts" {
  count = var.is_org_enabled ? 1 : 0

  name             = "root-account-alerts"
  description      = "Monitor & Alert on Root Account Activity"
  template_body    = file("${path.module}/CF-Stack-Template/root_account_alerts.yaml")
  permission_model = "SERVICE_MANAGED"
  parameters = {
    "snsEndpoint" = "${var.sns_endpoint}"
    "SnsProtocol" = "${var.sns_protocol}"
  }

  auto_deployment {
    enabled                          = true
    retain_stacks_on_account_removal = false
  }
}

## Root Account Alerts StackSet Instance(s) of Organizational Member Accounts ##
resource "aws_cloudformation_stack_set_instance" "root_account_alerts" {
  count = var.is_org_enabled ? 1 : 0

  stack_set_name = aws_cloudformation_stack_set.root_account_alerts[count.index].name
  region         = "us-east-1"
  retain_stack   = false

  deployment_targets {
    organizational_unit_ids = [data.aws_organizations_organization.aws_org[count.index].roots[0].id]
  }
}
