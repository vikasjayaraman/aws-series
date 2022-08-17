## Root User Login Event Rule ##
resource "aws_cloudwatch_event_rule" "root_login" {
  name        = "capture-root-login"
  description = "Capture Sign-In of Root User"

  event_pattern = <<EOF
{
  "source": ["aws.signin"],
  "detail-type": ["AWS Console Sign In via CloudTrail"],
  "detail": {
    "userIdentity": {
      "arn": ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
EOF

  provider = aws.iam-events
}

## Root User AK/SK Creation Event Rule ##
resource "aws_cloudwatch_event_rule" "root_keys" {
  name        = "capture-root-keys-creation"
  description = "Capture AK/SK Creation for Root User"

  event_pattern = <<EOF
{
  "source": ["aws.iam"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventSource": ["iam.amazonaws.com"],
    "eventName": ["CreateAccessKey"],
    "userIdentity": {
      "arn": ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    },
    "requestParameters": {
      "userName": [{
        "exists": false
      }]
    }
  }
}
EOF

  provider = aws.iam-events
}
