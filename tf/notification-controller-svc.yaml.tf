resource "kubernetes_manifest" "service_notification_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version" = "v0.9.0"
        "control-plane" = "controller"
      }
      "name" = "notification-controller"
      "namespace" = "flux-system"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "http"
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app" = "notification-controller"
      }
      "type" = "ClusterIP"
    }
  }
}
