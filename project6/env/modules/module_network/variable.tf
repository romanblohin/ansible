variable "vpc_subnet_name" {
  default = "prod-subnet"
}

variable "vpc_subnet_zone" {
  default = "ru-central1-a"
}

variable "net_id" {
  description = "Network ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
}
