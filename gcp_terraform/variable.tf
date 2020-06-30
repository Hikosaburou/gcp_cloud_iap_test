variable "project-name" {
  description = "GCP Project Name."
  type        = string

  default = "gcp-bigip-test"
}

variable "project-code" {
  description = "Project Code Name."
  type        = string

  default = "cloudiap-test"
}

variable "default-region" {
  description = "Default Region."
  type        = string

  default = "asia-northeast1"
}

variable "default-zone" {
  description = "Default VM Instance Zone."
  type        = string

  default = "asia-northeast1-b"
}

variable "instance-type" {
  description = "Cloud IAP Test Instance Type"
  type        = string

  default = "f1-micro"
}

variable "tag-tunnel" {
  description = "Tag value for Cloud IAP tunneling"
  type        = string

  default = "cloud-iap-tunnel"
}

