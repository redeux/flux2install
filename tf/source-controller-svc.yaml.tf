resource "kubernetes_manifest" "service_source_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
        "control-plane"              = "controller"
      }
      "name"      = "source-controller"
      "namespace" = "flux-system"
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app" = "source-controller"
      }
      "type" = "ClusterIP"
    }
  }
}
