variable "region" {
  description = "AWS Region Identifier"
  type        = string
  default     = "eu-west-1"
}

variable "sns_endpoint" {
  description = "SNS endpoint"
  type        = string
  default     = "john.doe@example.com"
}

variable "sns_protocol" {
  description = "SNS protocol"
  type        = string
  default     = "email"
}

variable "is_org_enabled" {
  description = "Flag to determine if the alerts have to be deployed and managed from Org Account"
  type        = bool
  default     = false
}
