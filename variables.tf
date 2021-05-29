#creating environment

# variable "env" {
#   type        = string
#   default     = "dev"
#   description = "Env to deploy to"
# }

variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

#creating a variable
variable "ext_port" {

  type = map(any)
  #default = 1880

  #
  # validation {
  #   condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) > 0
  #   error_message = "The ext port must be between range 0 and 65535."
  # }

  # validation {
  #   condition     = max(var.ext_port["prod"]...) <= 1979 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "The ext port must be between range 1880 and 1979."
  # }


}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal must be 1880."
  }
}

# variable "container_count" {
#   type    = number
#   default = 1
# }


# locals {
#   container_count = length(var.ext_port[terraform.workspace])
# }
