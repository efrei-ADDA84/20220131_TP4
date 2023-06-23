output "private_key_kg" {

  value     = tls_private_key.ssh_key.private_key_pem

  sensitive = true
}