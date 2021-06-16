resource "digitalocean_certificate" "cert" {
  name             = "cert"
  private_key      = file("./data/ssl/cloudflare.key")
  leaf_certificate = file("./data/ssl/cloudflare.pem")

  lifecycle {
    create_before_destroy = true
  }
}
