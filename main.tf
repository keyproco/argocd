resource "kubernetes_ingress_v1" "vault_ingress" {
  metadata {
    name = "argocd-ingress"

    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/",
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
    }
  }

  spec {
    rule {
      host = "argocd.keywe.dev"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "argocd-external"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "argocd_external" {
  metadata {
    name      = "argocd-external"
    namespace = "default"
  }

  spec {
    type          = "ExternalName"
    external_name = "argocd-server.argocd.svc.cluster.local"
    port {
      port        = 80
      target_port = 443
      protocol    = "TCP"
    }
  }
}



