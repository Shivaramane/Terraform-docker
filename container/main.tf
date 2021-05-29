resource "random_string" "random" {
  count = var.count_in
  # for_each = local.deployment
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "app_container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  # name = var.name_in
  image = var.image_in
  ports {
    internal = var.int_port_in
    # external = lookup(var.ext_port, terraform.workspace)[count.index]
    external = var.ext_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      # host_path = "/home/ubuntu/environment/Terraform_docker/noderedvol"
      # host_path = join("/",[path.cwd,"noderedvol"])
      volume_name = module.volume[count.index].volume_output[volumes.key]
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.name}: ${self.ip_address}: ${join("", [for x in self.ports[*]["external"] : x])} >> containers.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}
