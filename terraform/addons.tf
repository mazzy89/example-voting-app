resource "helm_release" "traefik" {
  name = "traefik-ingress-controller"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  namespace = "kube-system"

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-protocol"
    value = "http"
    type  = "string"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-certificate-id"
    value = digitalocean_certificate.cert.uuid
    type  = "string"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-tls-ports"
    value = "443"
    type  = "string"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/do-loadbalancer-redirect-http-to-https"
    value = "true"
    type  = "string"
  }
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

resource "helm_release" "app" {
  name = var.do_project_name

  repository = "../helm"
  chart      = var.do_project_name

  namespace = "default"

  set {
    name  = "result.envVars[0].name"
    value = "PORT"
  }

  set {
    name  = "result.envVars[0].value"
    value = "4000"
  }

  set {
    name  = "result.envVars[1].name"
    value = "PGHOST"
  }

  set {
    name  = "result.envVars[1].value"
    value = digitalocean_database_cluster.pg_cluster.private_host
  }

  set {
    name  = "result.envVars[2].name"
    value = "PGUSER"
  }

  set {
    name  = "result.envVars[2].value"
    value = digitalocean_database_user.pg_user.name
  }

  set {
    name  = "result.envVars[3].name"
    value = "PGDATABASE"
  }

  set {
    name  = "result.envVars[3].value"
    value = digitalocean_database_db.pg_db.name
  }

  set {
    name  = "result.envVars[4].name"
    value = "PGPASSWORD"
  }

  set {
    name  = "result.envVars[4].value"
    value = digitalocean_database_cluster.pg_cluster.password
  }

  set {
    name  = "result.envVars[5].name"
    value = "PGPORT"
  }

  set {
    name  = "result.envVars[5].value"
    value = digitalocean_database_cluster.pg_cluster.port
  }

  set {
    name  = "result.envVars[6].name"
    value = "PGSSLMODE"
  }

  set {
    name  = "result.envVars[6].value"
    value = "require"
  }


  set {
    name  = "worker.envVars[0].name"
    value = "PGHOST"
  }

  set {
    name  = "worker.envVars[0].value"
    value = digitalocean_database_cluster.pg_cluster.private_host
  }

  set {
    name  = "worker.envVars[1].name"
    value = "PGUSER"
  }

  set {
    name  = "worker.envVars[1].value"
    value = digitalocean_database_user.pg_user.name
  }

  set {
    name  = "worker.envVars[2].name"
    value = "PGDATABASE"
  }

  set {
    name  = "worker.envVars[2].value"
    value = digitalocean_database_db.pg_db.name
  }

  set {
    name  = "worker.envVars[3].name"
    value = "PGPASSWORD"
  }

  set {
    name  = "worker.envVars[3].value"
    value = digitalocean_database_cluster.pg_cluster.password
  }

  set {
    name  = "worker.envVars[4].name"
    value = "PGPORT"
  }

  set {
    name  = "worker.envVars[4].value"
    value = digitalocean_database_cluster.pg_cluster.port
  }


  set {
    name  = "worker.envVars[5].name"
    value = "REDIS_HOST"
  }

  set {
    name  = "worker.envVars[5].value"
    value = "${var.do_project_name}-redis.default.svc.cluster.local"
  }

  set {
    name  = "vote.envVars[0].name"
    value = "REDIS_HOST"
  }

  set {
    name  = "vote.envVars[0].value"
    value = "${var.do_project_name}-redis.default.svc.cluster.local"
  }
}

