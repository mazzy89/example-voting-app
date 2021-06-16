resource "digitalocean_database_cluster" "redis_cluster" {
  name                 = "${var.do_project_name}-redis"
  engine               = "redis"
  version              = "6"
  size                 = "db-s-1vcpu-1gb"
  region               = var.do_region
  private_network_uuid = digitalocean_vpc.network.id
  node_count           = 1
}
