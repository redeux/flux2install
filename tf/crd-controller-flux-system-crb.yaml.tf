resource "kubernetes_manifest" "clusterrolebinding_crd_controller_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
      }
      "name" = "crd-controller-flux-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "crd-controller-flux-system"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "kustomize-controller"
        "namespace" = "flux-system"
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "helm-controller"
        "namespace" = "flux-system"
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "source-controller"
        "namespace" = "flux-system"
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "notification-controller"
        "namespace" = "flux-system"
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-reflector-controller"
        "namespace" = "flux-system"
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-automation-controller"
        "namespace" = "flux-system"
      },
    ]
  }
}
