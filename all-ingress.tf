###############################
# ARGOCD
############################

resource "kubernetes_ingress_v1" "argocd_ingress" {
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

###############################
# OpenWebUI
############################

resource "kubernetes_ingress_v1" "owu_ingress" {
  metadata {
    name = "openwebui-ingress"

    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/",
    }
  }

  spec {
    rule {
      host = "owu.keywe.dev" # uwu :3

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "open-webui-external"
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


resource "kubernetes_service" "owu_external" {
  metadata {
    name      = "open-webui-external"
    namespace = "default"
  }

  spec {
    type          = "ExternalName"
    external_name = "open-webui.llm.svc.cluster.local"
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
  }
}