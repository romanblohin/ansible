terraform {
  required_version = "1.1.6"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.71.0"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

module "instance_ubuntu" {
  count           = 2
  source          = "./modules/module_instance"
  family_name     = "ubuntu-2004-lts"
  instancename   = "vm${count.index + 1}"
  instance_region = "ru-central1-a"
  subn_id         = module.subnet_1.subnet_id
}

module "instance_centos" {
  source          = "./modules/module_instance"
  family_name     = "centos-7"
  instancename   = "vm3"
  instance_region = "ru-central1-a"
  subn_id         = module.subnet_1.subnet_id
}

# Creating VPC and Subnets for Instances

resource "yandex_vpc_network" "foo" {
  name = "network1"
}

module "subnet_1" {
  source          = "./modules/module_network"
  vpc_subnet_name = "subnet_1"
  vpc_subnet_zone = "ru-central1-a"
  net_id          = yandex_vpc_network.foo.id
  vpc_cidr        = ["10.2.0.0/16"]
}

data "template_file" "ansible_inventory" {
  template = file("hosts.txt.tpl")
  vars = {
    vm1_ip = module.instance_ubuntu.0.public_ip
    vm2_ip = module.instance_ubuntu.1.public_ip
    vm3_ip = module.instance_centos.public_ip
  }

}

resource "null_resource" "update_inventory" {
  triggers = {
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory.rendered}' > hosts.txt"
  }
}
