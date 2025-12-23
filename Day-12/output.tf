output "pro-name" {
    value = substr(local.proj-name, 0,3)
}

output "data" {
    value = local.data
}

output "specdate" {
    value = local.day
}