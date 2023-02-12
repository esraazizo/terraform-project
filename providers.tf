provider "aws" {
  shared_config_files      = ["./.aws/conf"]
  shared_credentials_files = ["./.aws/cred"]
  profile                  = "admin_esraa"
  region                   = "us-east-2"
}