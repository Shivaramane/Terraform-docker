resource "docker_image" "container_image" {
  name = var.image_in
  # name = lookup(var.image, terraform.workspace)
  #The above is same as below , instead of using the lookup func, we are using the map key
  #   name = var.image[terraform.workspace]
}