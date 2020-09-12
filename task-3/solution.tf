module "us-east-1-stack" {
  source = "./us-east-1/"
}

module "us-west-2-stack" {
  source = "./us-west-2"
}

output "us-east-dns" {
  value = module.us-east-1-stack.dns_endpoint
}

output "us-west-dns" {
  value = module.us-west-2-stack.dns_endpoint
}