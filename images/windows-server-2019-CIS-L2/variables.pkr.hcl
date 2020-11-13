variable "benchmark_name" {
  type    = string
  default = "CIS_Microsoft_Windows_Server_2019_Benchmark_v1.1.0-xccdf"
}

variable "build_resource_group_name" {
  type    = string
  default = ""
}

variable "client_id" {
  type    = string
  default = "${var.ARM_CLIENT_ID}"
}

variable "client_secret" {
  type    = string
  default = "${var.ARM_CLIENT_SECRET}"
}

variable "destination_gallery_name" {
  type    = string
  default = "sig001"
}

variable "destination_image_name" {
  type    = string
  default = "image"
}

variable "destination_image_version" {
  type    = string
  default = "version"
}

variable "destination_replication_region" {
  type    = string
  default = "northeurope"
}

variable "destination_resource_group_location" {
  type    = string
  default = "northeurope"
}

variable "destination_resource_group_name" {
  type    = string
  default = "sharedImageGallery"
}

variable "helper_script_folder" {
  type    = string
  default = "c:/buildartifacts"
}

variable "image_offer" {
  type    = string
  default = ""
}

variable "image_publisher" {
  type    = string
  default = ""
}

variable "image_sku" {
  type    = string
  default = ""
}

variable "image_version" {
  type    = string
  default = ""
}

variable "reports_storage_account_url" {
  type    = string
  default = "https://someblob.blob.core.windows.net/reports"
}

variable "storage_account_url" {
  type    = string
  default = "https://someblob.blob.core.windows.net/tools"
}

variable "subscription_id" {
  type    = string
  default = "${var.ARM_SUBSCRIPTION_ID}"
}

variable "tenant_id" {
  type    = string
  default = "${var.ARM_TENANT_ID}"
}

variable "vm_size" {
  type    = string
  default = "Standard_D2_v2"
}