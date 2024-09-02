variable "key_name" {
  type        = string
  default     = "practice_key"
  description = "The name of the key pair to use for the EC2 instances"
}

variable "db_instance_password" {
  type        = string
  default     = "foofoo"
  description = "The password for the RDS instance"
}