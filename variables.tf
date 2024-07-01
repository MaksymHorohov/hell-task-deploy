variable "db_password" {
  type = "string"
}

variable "db_user" {
  type = "string"
}

variable "sqs_delay_seconds" {
  type = "string"
}

variable "maximum_message_size" {
  type = "string"
}

variable "message_retention_period" {
  type = "string"
}

variable "receive_message_wait_time_seconds" {
  type = "string"
}

#variable "JENKINS_URL" {
#  type = "string"
#}
#
#variable "JENKINS_USERNAME" {
#  type = "string"
#}
#
#variable "JENKINS_PASSWORD" {
#  type = "string"
#}