resource "kubernetes_manifest" "deployment_helm_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
        "control-plane"              = "controller"
      }
      "name"      = "helm-controller"
      "namespace" = "flux-system"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "helm-controller"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "prometheus.io/port"   = "8080"
            "prometheus.io/scrape" = "true"
          }
          "labels" = {
            "app" = "helm-controller"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--events-addr=http://notification-controller/",
                "--watch-all-namespaces=true",
                "--log-level=info",
                "--log-encoding=json",
                "--enable-leader-election",
              ]
              "env" = [
                {
                  "name" = "RUNTIME_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image"           = "ghcr.io/fluxcd/helm-controller:v0.8.0"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = "healthz"
                }
              }
              "name" = "manager"
              "ports" = [
                {
                  "containerPort" = 9440
                  "name"          = "healthz"
                  "protocol"      = "TCP"
                },
                {
                  "containerPort" = 8080
                  "name"          = "http-prom"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/readyz"
                  "port" = "healthz"
                }
              }
              "resources" = {
                "limits" = {
                  "cpu"    = "1"
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu"    = "100m"
                  "memory" = "64Mi"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem"   = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/tmp"
                  "name"      = "temp"
                },
              ]
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName"            = "helm-controller"
          "terminationGracePeriodSeconds" = 600
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "temp"
            },
          ]
        }
      }
    }
  }
}
output "deployment_helm_controller" {
  value = kubernetes_manifest.deployment_helm_controller
}