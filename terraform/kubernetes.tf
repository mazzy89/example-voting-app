resource "digitalocean_kubernetes_cluster" "example_voting_app" {
  name = "example-voting-app"

  region  = "fra1"
  version = var.kubernetes_version

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = var.nodes_count
  }
}
