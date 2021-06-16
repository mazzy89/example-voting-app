resource "digitalocean_vpc" "network" {
  name   = var.do_project_name
  region = var.do_region
}

resource "digitalocean_database_firewall" "fw" {
  cluster_id = digitalocean_database_cluster.pg_cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }
}

resource "digitalocean_database_firewall" "fw_redis" {
  cluster_id = digitalocean_database_cluster.redis_cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.cluster.id
  }
}
