variable "do_token" {
  type      = string
  sensitive = true
}

variable "do_region" {
  type    = string
  default = "fra1"
}

variable "do_project_name" {
  default = "example-voting-app"
}

variable "kubernetes_version" {
  type    = string
  default = "1.20.7-do.0"
}

variable "nodes_count" {
  type    = number
  default = 3
}
