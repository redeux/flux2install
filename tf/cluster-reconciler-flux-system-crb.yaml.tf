resource "kubernetes_manifest" "clusterrolebinding_cluster_reconciler_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version" = "v0.9.0"
      }
      "name" = "cluster-reconciler-flux-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "cluster-admin"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "kustomize-controller"
        "namespace" = "flux-system"
      },
      {
        "kind" = "ServiceAccount"
        "name" = "helm-controller"
        "namespace" = "flux-system"
      },
    ]
  }
}
