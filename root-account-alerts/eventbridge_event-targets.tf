## Root User Login Event Target ##
resource "aws_cloudwatch_event_target" "sns_root_login" {
  rule      = aws_cloudwatch_event_rule.root_login.name
  target_id = "RootAlertsTopic"
  arn       = aws_sns_topic.root_alerts.arn

  provider = aws.iam-events

  input_transformer {
    input_paths = {
      account_id = "$.account",
      event_id   = "$.detail.eventID",
      event_name = "$.detail.eventName",
      event_time = "$.detail.eventTime",
      source_ip  = "$.detail.sourceIPAddress",
      user_arn   = "$.detail.userIdentity.arn"
    }
    input_template = <<EOF
{
  "Event ID": "<event_id>",
  "Event Name": "<event_name>",
  "Event Time": "<event_time>",
  "Account ID": "<account_id>",
  "User": "<user_arn>",
  "Source IP": "<source_ip>",
  "Message": "[Warn] Console Login detected for Root User"
}
EOF
  }
}

## Root User AK/SK Creation Event Target ##
resource "aws_cloudwatch_event_target" "sns_root_keys" {
  rule      = aws_cloudwatch_event_rule.root_keys.name
  target_id = "RootAlertsTopic"
  arn       = aws_sns_topic.root_alerts.arn

  provider = aws.iam-events

  input_transformer {
    input_paths = {
      account_id = "$.account",
      event_id   = "$.detail.eventID",
      event_name = "$.detail.eventName",
      event_time = "$.detail.eventTime",
      user_arn   = "$.detail.userIdentity.arn",
      user_name  = "$.detail.userIdentity.userName"
    }
    input_template = <<EOF
{
  "Event ID": "<event_id>",
  "Event Name": "<event_name>",
  "Event Time": "<event_time>",
  "Account ID": "<account_id>",
  "User": "<user_name> (<user_arn>)",
  "Message": "[Warn] AWS App Keys created for Root User"
}
EOF
  }
}
