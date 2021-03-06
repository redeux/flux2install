resource "kubernetes_manifest" "networkpolicy_allow_scraping" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
      }
      "name"      = "allow-scraping"
      "namespace" = "flux-system"
    }
    "spec" = {
      "ingress" = [
        {
          # "from" = [
          #   {
          #     "namespaceSelector" = {}
          #   },
          # ]
          "ports" = [
            {
              "port"     = 8080
              "protocol" = "TCP"
            },
          ]
        },
      ]
      "podSelector" = {}
      "policyTypes" = [
        "Ingress",
      ]
    }
  }
}
