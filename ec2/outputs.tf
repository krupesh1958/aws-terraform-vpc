# Output the private key in PEM format
output "private_key" {
  value     = tls_private_key.key.private_key_pem
  description = "The private key in PEM format"
}
