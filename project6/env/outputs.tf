output "ubuntu_public_ip" {
  description = "Public Ipv4 address of ubuntu servers"
  value       = module.instance_ubuntu.*.public_ip
}

output "centos_public_ip" {
  description = "Public Ipv4 address of centos server"
  value       = module.instance_centos.public_ip
}
