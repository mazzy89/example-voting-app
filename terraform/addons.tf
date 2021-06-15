resource "helm_release" "traefik" {
  name = "traefik-ingress-controller"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  namespace = "kube-system"
}

resource "helm_release" "kube_prometheus_stack" {
  name = "prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = true
  namespace        = "monitoring"

  set {
    name  = "alertmanager.enabled"
    value = "false"
  }
}
