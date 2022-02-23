variable "family_name" {
  description = "Family name"
  type        = string
}

variable "subn_id" {
  description = "Subnet ID"
  type        = string
}

variable "instance_region" {
  default = "ru-central1-a"
}

variable "instancename" {
  description = "Instance name"
  type        = string
}
