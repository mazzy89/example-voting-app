resource "digitalocean_kubernetes_cluster" "cluster" {
  name = var.do_project_name

  region  = var.do_region
  version = var.kubernetes_version

  vpc_uuid = digitalocean_vpc.network.id

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = var.nodes_count
  }
}
