variable "public_key_file" {
type = string
default = "~/.ssh/id_rsa.pub"
}
resource "null_resource" "cretae_host_file" {
