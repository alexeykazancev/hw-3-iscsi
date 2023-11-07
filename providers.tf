provider "libvirt" {
  ## Configuration options
  #uri = "qemu:///system"
  #alias = "kvm-64-138"
  uri   = "qemu+ssh://root@10.128.64.138/system"
}