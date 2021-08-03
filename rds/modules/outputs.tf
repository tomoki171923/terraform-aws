output "db" {
  value = {
    postgres = module.postgres
  }
  # Must mark this output value as sensitive, because it's derived from
  # var.example that is declared as sensitive.
  sensitive = true
}
