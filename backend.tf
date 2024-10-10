terraform {
  required_providers {
    argocd = {
      source = "argoproj-labs/argocd"
      version = "7.0.0"
    }
  }
}

provider "argocd" {
          server_addr = "argocd.keywe.dev"
          username = var.argocd.user
          password =  var.argocd.password
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }

}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
