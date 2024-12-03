resource "libvirt_pool" "ubuntu" {
  name = "ubuntu"
  type = "dir"
  path = "/tmp/terraform-provider-libvirt-pool-ubuntu"
}
