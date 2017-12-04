variable "zone_id" {}

variable "environment" {
  default = "dev"
}

variable "zone_name" {
  default = "client"
}

variable "dns_entry" {
  default = "app"
}

variable "ip_address" {
  default = "0.0.0.0"
}
