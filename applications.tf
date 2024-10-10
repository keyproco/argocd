resource "argocd_application" "openweb_ui" {
  metadata {
    name      = "open-webui"
    namespace = "argocd"
  }

  spec {
    project = "default"

    destination {
      namespace = "llm"
      name      = "in-cluster"
    }

    source {
      repo_url        = "https://helm.openwebui.com"
      target_revision = "3.3.2" # 0.3.32
      chart           = "open-webui"

      #   helm {
      #     parameter {
      #       name  = ""
      #       value = ""
      #     }
      #   }
    }

    sync_policy {
      automated {
        prune     = true
        self_heal = true
      }

      sync_options = ["CreateNamespace=true"]
    }
  }
}