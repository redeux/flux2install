resource "kubernetes_manifest" "serviceaccount_kustomize_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
      }
      "name"      = "kustomize-controller"
      "namespace" = "flux-system"
    }
  }
}
