resource "digitalocean_database_cluster" "pg_cluster" {
  name = "${var.do_project_name}-pg"

  engine  = "pg"
  version = "11"
  size    = "db-s-1vcpu-1gb"

  region     = var.do_region
  node_count = 1

  private_network_uuid = digitalocean_vpc.network.id
}

resource "digitalocean_database_db" "pg_db" {
  cluster_id = digitalocean_database_cluster.pg_cluster.id
  name       = var.do_project_name
}

resource "digitalocean_database_user" "pg_user" {
  cluster_id = digitalocean_database_cluster.pg_cluster.id
  name       = var.do_project_name
}
