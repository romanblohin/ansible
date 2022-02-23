terraform {
  required_version = "1.1.6"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.71.0"
    }
  }

}

resource "yandex_vpc_subnet" "foo" {
  name           = var.vpc_subnet_name
  zone           = var.vpc_subnet_zone
  network_id     = var.net_id
  v4_cidr_blocks = var.vpc_cidr
}
