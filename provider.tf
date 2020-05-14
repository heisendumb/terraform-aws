provider "aws" {
  region  = var.region_dev
  alias   = "dev"
  profile = var.awsprofile
}

provider "aws" {
  region  = var.region_prd
  alias   = "prd"
  profile = var.awsprofile
}
