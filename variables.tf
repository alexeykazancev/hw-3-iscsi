variable "prefix" {
  type    = string
  default = "node-"
}

# Путь, где будет хранится пул проекта
variable "pool_path" {
  type    = string
  default = "/mnt/vm/vm/"
}

# Параметры облачного образа
variable "image" {
  type = object({
    name = string
    url  = string
  })
}

variable "password" {
  type = string
}

# Параметры виртуальной машины
variable "vm" {
  type = object({
    cpu    = number
    ram    = number
    disk   = number
    count = number
    bridge = string
  })
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}