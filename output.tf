

output "application_access" {
  #   value = [for x in module.container[*]: x]
  value = [module.container[*]]
}