variable "argocd" {
  type = map(string)
  default = {
    server   = "argocd.keywe.dev"
    user     = "admin"
    passowrd = ""
  }
}