## Root Alerts SNS Topic ##
resource "aws_sns_topic" "root_alerts" {
  name = "root-alerts"

  provider = aws.iam-events
}

## Root Alerts SNS Topic Subscription (Default: email to john.doe@example.com) ##
resource "aws_sns_topic_subscription" "root_alerts_sub" {
  topic_arn = aws_sns_topic.root_alerts.arn
  protocol  = var.sns_protocol
  endpoint  = var.sns_endpoint

  provider = aws.iam-events
}

## Root Alerts SNS Topic Policy ##
resource "aws_sns_topic_policy" "root_alerts_sns_policy" {
  arn    = aws_sns_topic.root_alerts.arn
  policy = data.aws_iam_policy_document.root_alerts_policy_doc.json

  provider = aws.iam-events
}

## Root Alerts SNS Topic Policy Document ##
data "aws_iam_policy_document" "root_alerts_policy_doc" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.root_alerts.arn]
  }
}
