#CCreating a null resource to place the local-exec provisioner

# resource "null_resource" "dockervol" {
#   provisioner "local-exec" {
#     command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
#   }
# }





#Run terraform init here for initialization, to download the dependencies for docker provider

module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}


#Terraform looks for the image from the variables.tf from the root dir and passed here.After this
#This value is referenced to the image_in variable created in the variable.tf - module
#The variable.tf in the module will then pass the image details to the module main.tf 


module "container" {
  source = "./container"
  # depends_on  = [null_resource.dockervol]
  count_in = each.value.container_count
  for_each = local.deployment

  name_in     = each.key
  image_in    = module.image[each.key].image_out
  int_port_in = each.value.int
  # external = lookup(var.ext_port, terraform.workspace)[count.index]
  ext_port_in = each.value.ext
  # host_path = "/home/ubuntu/environment/Terraform_docker/noderedvol"
  # host_path = join("/",[path.cwd,"noderedvol"])
  # host_path_in = "${path.cwd}/noderedvol"
  volumes_in = each.value.volumes
}




