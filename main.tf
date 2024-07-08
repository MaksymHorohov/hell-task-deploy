provider "aws" {
  region  = "us-east-1"
  version = "2.70.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "aws_instance" "app_server" {
  ami           = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"

  tags = {
    Name = "MyApp"
  }
}

resource "aws_db_instance" "rds" {
  identifier          = "rds"
  instance_class      = "db.t3.micro"
  allocated_storage   = 5
  engine              = "postgres"
  engine_version      = "14.1"
  username            = "${var.db_user}"
  password            = "${var.db_password}"
  publicly_accessible = true
  skip_final_snapshot = true
}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket"
  tags   = {
    Name = "MyBucket"
  }
}

resource "aws_sqs_queue" "sqs-queue" {
  queue_name                        = "sqs-queue"
  delay_seconds                     = "${var.sqs_delay_seconds}"
  maximum_message_size              = "${var.maximum_message_size}"
  message_retention_period          = "${var.message_retention_period}"
  receive_message_wait_time_seconds = "${var.receive_message_wait_time_seconds}"
  tags                              = {
    Name = "MySQS"
  }
}

#Service IAMs

resource "aws_iam_user" "userService" {
  name = "userService"
}

resource "aws_iam_access_key" "userService" {
  user = "${aws_iam_user.userService.name}"
}

data "aws_iam_policy_document" "userService" {
  statement {
    effect    = "Allow"
    actions   = ["rds-db:connect"]
    resources = ["${aws_db_instance.rds.arn}"]
  }
}

resource "aws_iam_user_policy" "userService" {
  name   = "test"
  user   = "${aws_iam_user.userService.name}"
  policy = "${data.aws_iam_policy_document.userService.json}"
}





