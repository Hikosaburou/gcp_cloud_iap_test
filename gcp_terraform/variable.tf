variable "project_name" {
  description = "GCP Project Name."
  type        = string
}

variable "project_prefix" {
  description = "Prefix code."
  type        = string

  default = "iap-test"
}

variable "default_region" {
  description = "Default Region."
  type        = string

  default = "asia-northeast1"
}

variable "default_zone" {
  description = "Default VM Instance Zone."
  type        = string

  default = "asia-northeast1-b"
}

variable "instance_type" {
  description = "Cloud IAP Test Instance Type"
  type        = string

  default = "f1-micro"
}

variable "tag_tunnel" {
  description = "Tag value for Cloud IAP tunneling"
  type        = string

  default = "cloud-iap-tunnel"
}

variable "tag_allow_http" {
  description = "Tag value for HTTP access to Compute Engine instances"
  type        = string

  default = "instance-template-http"
}

## variables.tfvarsで値を定義する
variable "lb_host" {
  description = "Hostname for global load balancing"
  type = string
}
