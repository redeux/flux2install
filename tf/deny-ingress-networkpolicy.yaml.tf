resource "kubernetes_manifest" "networkpolicy_deny_ingress" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind" = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version" = "v0.9.0"
      }
      "name" = "deny-ingress"
      "namespace" = "flux-system"
    }
    "spec" = {
      "egress" = [
        {},
      ]
      "ingress" = [
        {
          "from" = [
            {
              "podSelector" = {}
            },
          ]
        },
      ]
      "podSelector" = {}
      "policyTypes" = [
        "Ingress",
        "Egress",
      ]
    }
  }
}
