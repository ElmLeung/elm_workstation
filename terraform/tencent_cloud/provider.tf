terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
      # 通过version指定版本
      # version = ">=1.60.18"
    }
  }
}
provider "tencentcloud" {
  region = "ap-guangzhou"
  #secret_id = ""
  #secret_key = ""
}
