resource "helm_release" "traefik" {
  name = "traefik-ingress-controller"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  namespace = "kube-system"
}
