variable "app_name" {
  default = ""
}

variable "public_ip" {
  default = false
}

variable "attach_eip" {
  default = false
}

variable "allow_ssh" {
  default = false
}

variable "shared_bucket" {
  default = "dev-dc-terraform"
}
