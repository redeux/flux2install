resource "kubernetes_manifest" "customresourcedefinition_helmreleases_helm_toolkit_fluxcd_io" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.4.1"
      }
      "labels" = {
        "app.kubernetes.io/instance" = "flux-system"
        "app.kubernetes.io/version"  = "v0.9.0"
      }
      "name" = "helmreleases.helm.toolkit.fluxcd.io"
    }
    "spec" = {
      "group" = "helm.toolkit.fluxcd.io"
      "names" = {
        "kind"     = "HelmRelease"
        "listKind" = "HelmReleaseList"
        "plural"   = "helmreleases"
        "shortNames" = [
          "hr",
        ]
        "singular" = "helmrelease"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name"     = "Ready"
              "type"     = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name"     = "Status"
              "type"     = "string"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name"     = "Age"
              "type"     = "date"
            },
          ]
          "name" = "v2beta1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "HelmRelease is the Schema for the helmreleases API"
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type"        = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type"        = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "HelmReleaseSpec defines the desired state of a Helm release."
                  "properties" = {
                    "chart" = {
                      "description" = "Chart defines the template of the v1beta1.HelmChart that should be created for this HelmRelease."
                      "properties" = {
                        "spec" = {
                          "description" = "Spec holds the template for the v1beta1.HelmChartSpec for this HelmRelease."
                          "properties" = {
                            "chart" = {
                              "description" = "The name or path the Helm chart is available at in the SourceRef."
                              "type"        = "string"
                            }
                            "interval" = {
                              "description" = "Interval at which to check the v1beta1.Source for updates. Defaults to 'HelmReleaseSpec.Interval'."
                              "type"        = "string"
                            }
                            "sourceRef" = {
                              "description" = "The name and namespace of the v1beta1.Source the chart is available at."
                              "properties" = {
                                "apiVersion" = {
                                  "description" = "APIVersion of the referent."
                                  "type"        = "string"
                                }
                                "kind" = {
                                  "description" = "Kind of the referent."
                                  "enum" = [
                                    "HelmRepository",
                                    "GitRepository",
                                    "Bucket",
                                  ]
                                  "type" = "string"
                                }
                                "name" = {
                                  "description" = "Name of the referent."
                                  "maxLength"   = 253
                                  "minLength"   = 1
                                  "type"        = "string"
                                }
                                "namespace" = {
                                  "description" = "Namespace of the referent."
                                  "maxLength"   = 63
                                  "minLength"   = 1
                                  "type"        = "string"
                                }
                              }
                              "required" = [
                                "name",
                              ]
                              "type" = "object"
                            }
                            "valuesFile" = {
                              "description" = "Alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Ignored when omitted."
                              "type"        = "string"
                            }
                            "version" = {
                              "default"     = "*"
                              "description" = "Version semver expression, ignored for charts from v1beta1.GitRepository and v1beta1.Bucket sources. Defaults to latest when omitted."
                              "type"        = "string"
                            }
                          }
                          "required" = [
                            "chart",
                            "sourceRef",
                          ]
                          "type" = "object"
                        }
                      }
                      "required" = [
                        "spec",
                      ]
                      "type" = "object"
                    }
                    "dependsOn" = {
                      "description" = "DependsOn may contain a dependency.CrossNamespaceDependencyReference slice with references to HelmRelease resources that must be ready before this HelmRelease can be reconciled."
                      "items" = {
                        "description" = "CrossNamespaceDependencyReference holds the reference to a dependency."
                        "properties" = {
                          "name" = {
                            "description" = "Name holds the name reference of a dependency."
                            "type"        = "string"
                          }
                          "namespace" = {
                            "description" = "Namespace holds the namespace reference of a dependency."
                            "type"        = "string"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "install" = {
                      "description" = "Install holds the configuration for Helm install actions for this HelmRelease."
                      "properties" = {
                        "createNamespace" = {
                          "description" = "CreateNamespace tells the Helm install action to create the HelmReleaseSpec.TargetNamespace if it does not exist yet. On uninstall, the namespace will not be garbage collected."
                          "type"        = "boolean"
                        }
                        "disableHooks" = {
                          "description" = "DisableHooks prevents hooks from running during the Helm install action."
                          "type"        = "boolean"
                        }
                        "disableOpenAPIValidation" = {
                          "description" = "DisableOpenAPIValidation prevents the Helm install action from validating rendered templates against the Kubernetes OpenAPI Schema."
                          "type"        = "boolean"
                        }
                        "disableWait" = {
                          "description" = "DisableWait disables the waiting for resources to be ready after a Helm install has been performed."
                          "type"        = "boolean"
                        }
                        "remediation" = {
                          "description" = "Remediation holds the remediation configuration for when the Helm install action for the HelmRelease fails. The default is to not perform any action."
                          "properties" = {
                            "ignoreTestFailures" = {
                              "description" = "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an install action but fail. Defaults to 'Test.IgnoreFailures'."
                              "type"        = "boolean"
                            }
                            "remediateLastFailure" = {
                              "description" = "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false'."
                              "type"        = "boolean"
                            }
                            "retries" = {
                              "description" = "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using an uninstall, is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."
                              "type"        = "integer"
                            }
                          }
                          "type" = "object"
                        }
                        "replace" = {
                          "description" = "Replace tells the Helm install action to re-use the 'ReleaseName', but only if that name is a deleted release which remains in the history."
                          "type"        = "boolean"
                        }
                        "skipCRDs" = {
                          "description" = "SkipCRDs tells the Helm install action to not install any CRDs. By default, CRDs are installed if not already present."
                          "type"        = "boolean"
                        }
                        "timeout" = {
                          "description" = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm install action. Defaults to 'HelmReleaseSpec.Timeout'."
                          "type"        = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "interval" = {
                      "description" = "Interval at which to reconcile the Helm release."
                      "type"        = "string"
                    }
                    "kubeConfig" = {
                      "description" = "KubeConfig for reconciling the HelmRelease on a remote cluster. When specified, KubeConfig takes precedence over ServiceAccountName."
                      "properties" = {
                        "secretRef" = {
                          "description" = "SecretRef holds the name to a secret that contains a 'value' key with the kubeconfig file as the value. It must be in the same namespace as the HelmRelease. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling the HelmRelease."
                          "properties" = {
                            "name" = {
                              "description" = "Name of the referent"
                              "type"        = "string"
                            }
                          }
                          "required" = [
                            "name",
                          ]
                          "type" = "object"
                        }
                      }
                      "type" = "object"
                    }
                    "maxHistory" = {
                      "description" = "MaxHistory is the number of revisions saved by Helm for this HelmRelease. Use '0' for an unlimited number of revisions; defaults to '10'."
                      "type"        = "integer"
                    }
                    "postRenderers" = {
                      "description" = "PostRenderers holds an array of Helm PostRenderers, which will be applied in order of their definition."
                      "items" = {
                        "description" = "PostRenderer contains a Helm PostRenderer specification."
                        "properties" = {
                          "kustomize" = {
                            "description" = "Kustomization to apply as PostRenderer."
                            "properties" = {
                              "images" = {
                                "description" = "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."
                                "items" = {
                                  "description" = "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."
                                  "properties" = {
                                    "digest" = {
                                      "description" = "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."
                                      "type"        = "string"
                                    }
                                    "name" = {
                                      "description" = "Name is a tag-less image name."
                                      "type"        = "string"
                                    }
                                    "newName" = {
                                      "description" = "NewName is the value used to replace the original name."
                                      "type"        = "string"
                                    }
                                    "newTag" = {
                                      "description" = "NewTag is the value used to replace the original tag."
                                      "type"        = "string"
                                    }
                                  }
                                  "required" = [
                                    "name",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "patchesJson6902" = {
                                "description" = "JSON 6902 patches, defined as inline YAML objects."
                                "items" = {
                                  "description" = "JSON6902Patch contains a JSON6902 patch and the target the patch should be applied to."
                                  "properties" = {
                                    "patch" = {
                                      "description" = "Patch contains the JSON6902 patch document with an array of operation objects."
                                      "items" = {
                                        "description" = "JSON6902 is a JSON6902 operation object. https://tools.ietf.org/html/rfc6902#section-4"
                                        "properties" = {
                                          "from" = {
                                            "type" = "string"
                                          }
                                          "op" = {
                                            "enum" = [
                                              "test",
                                              "remove",
                                              "add",
                                              "replace",
                                              "move",
                                              "copy",
                                            ]
                                            "type" = "string"
                                          }
                                          "path" = {
                                            "type" = "string"
                                          }
                                          "value" = {
                                            "x-kubernetes-preserve-unknown-fields" = true
                                          }
                                        }
                                        "required" = [
                                          "op",
                                          "path",
                                        ]
                                        "type" = "object"
                                      }
                                      "type" = "array"
                                    }
                                    "target" = {
                                      "description" = "Target points to the resources that the patch document should be applied to."
                                      "properties" = {
                                        "annotationSelector" = {
                                          "description" = "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."
                                          "type"        = "string"
                                        }
                                        "group" = {
                                          "description" = "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"
                                          "type"        = "string"
                                        }
                                        "kind" = {
                                          "description" = "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"
                                          "type"        = "string"
                                        }
                                        "labelSelector" = {
                                          "description" = "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."
                                          "type"        = "string"
                                        }
                                        "name" = {
                                          "description" = "Name to match resources with."
                                          "type"        = "string"
                                        }
                                        "namespace" = {
                                          "description" = "Namespace to select resources from."
                                          "type"        = "string"
                                        }
                                        "version" = {
                                          "description" = "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"
                                          "type"        = "string"
                                        }
                                      }
                                      "type" = "object"
                                    }
                                  }
                                  "required" = [
                                    "patch",
                                    "target",
                                  ]
                                  "type" = "object"
                                }
                                "type" = "array"
                              }
                              "patchesStrategicMerge" = {
                                "description" = "Strategic merge patches, defined as inline YAML objects."
                                "items" = {
                                  "x-kubernetes-preserve-unknown-fields" = true
                                }
                                "type" = "array"
                              }
                            }
                            "type" = "object"
                          }
                        }
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "releaseName" = {
                      "description" = "ReleaseName used for the Helm release. Defaults to a composition of '[TargetNamespace-]Name'."
                      "maxLength"   = 53
                      "minLength"   = 1
                      "type"        = "string"
                    }
                    "rollback" = {
                      "description" = "Rollback holds the configuration for Helm rollback actions for this HelmRelease."
                      "properties" = {
                        "cleanupOnFail" = {
                          "description" = "CleanupOnFail allows deletion of new resources created during the Helm rollback action when it fails."
                          "type"        = "boolean"
                        }
                        "disableHooks" = {
                          "description" = "DisableHooks prevents hooks from running during the Helm rollback action."
                          "type"        = "boolean"
                        }
                        "disableWait" = {
                          "description" = "DisableWait disables the waiting for resources to be ready after a Helm rollback has been performed."
                          "type"        = "boolean"
                        }
                        "force" = {
                          "description" = "Force forces resource updates through a replacement strategy."
                          "type"        = "boolean"
                        }
                        "recreate" = {
                          "description" = "Recreate performs pod restarts for the resource if applicable."
                          "type"        = "boolean"
                        }
                        "timeout" = {
                          "description" = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm rollback action. Defaults to 'HelmReleaseSpec.Timeout'."
                          "type"        = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "serviceAccountName" = {
                      "description" = "The name of the Kubernetes service account to impersonate when reconciling this HelmRelease."
                      "type"        = "string"
                    }
                    "storageNamespace" = {
                      "description" = "StorageNamespace used for the Helm storage. Defaults to the namespace of the HelmRelease."
                      "maxLength"   = 63
                      "minLength"   = 1
                      "type"        = "string"
                    }
                    "suspend" = {
                      "description" = "Suspend tells the controller to suspend reconciliation for this HelmRelease, it does not apply to already started reconciliations. Defaults to false."
                      "type"        = "boolean"
                    }
                    "targetNamespace" = {
                      "description" = "TargetNamespace to target when performing operations for the HelmRelease. Defaults to the namespace of the HelmRelease."
                      "maxLength"   = 63
                      "minLength"   = 1
                      "type"        = "string"
                    }
                    "test" = {
                      "description" = "Test holds the configuration for Helm test actions for this HelmRelease."
                      "properties" = {
                        "enable" = {
                          "description" = "Enable enables Helm test actions for this HelmRelease after an Helm install or upgrade action has been performed."
                          "type"        = "boolean"
                        }
                        "ignoreFailures" = {
                          "description" = "IgnoreFailures tells the controller to skip remediation when the Helm tests are run but fail. Can be overwritten for tests run after install or upgrade actions in 'Install.IgnoreTestFailures' and 'Upgrade.IgnoreTestFailures'."
                          "type"        = "boolean"
                        }
                        "timeout" = {
                          "description" = "Timeout is the time to wait for any individual Kubernetes operation during the performance of a Helm test action. Defaults to 'HelmReleaseSpec.Timeout'."
                          "type"        = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "timeout" = {
                      "description" = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm action. Defaults to '5m0s'."
                      "type"        = "string"
                    }
                    "uninstall" = {
                      "description" = "Uninstall holds the configuration for Helm uninstall actions for this HelmRelease."
                      "properties" = {
                        "disableHooks" = {
                          "description" = "DisableHooks prevents hooks from running during the Helm rollback action."
                          "type"        = "boolean"
                        }
                        "keepHistory" = {
                          "description" = "KeepHistory tells Helm to remove all associated resources and mark the release as deleted, but retain the release history."
                          "type"        = "boolean"
                        }
                        "timeout" = {
                          "description" = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm uninstall action. Defaults to 'HelmReleaseSpec.Timeout'."
                          "type"        = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "upgrade" = {
                      "description" = "Upgrade holds the configuration for Helm upgrade actions for this HelmRelease."
                      "properties" = {
                        "cleanupOnFail" = {
                          "description" = "CleanupOnFail allows deletion of new resources created during the Helm upgrade action when it fails."
                          "type"        = "boolean"
                        }
                        "disableHooks" = {
                          "description" = "DisableHooks prevents hooks from running during the Helm upgrade action."
                          "type"        = "boolean"
                        }
                        "disableOpenAPIValidation" = {
                          "description" = "DisableOpenAPIValidation prevents the Helm upgrade action from validating rendered templates against the Kubernetes OpenAPI Schema."
                          "type"        = "boolean"
                        }
                        "disableWait" = {
                          "description" = "DisableWait disables the waiting for resources to be ready after a Helm upgrade has been performed."
                          "type"        = "boolean"
                        }
                        "force" = {
                          "description" = "Force forces resource updates through a replacement strategy."
                          "type"        = "boolean"
                        }
                        "preserveValues" = {
                          "description" = "PreserveValues will make Helm reuse the last release's values and merge in overrides from 'Values'. Setting this flag makes the HelmRelease non-declarative."
                          "type"        = "boolean"
                        }
                        "remediation" = {
                          "description" = "Remediation holds the remediation configuration for when the Helm upgrade action for the HelmRelease fails. The default is to not perform any action."
                          "properties" = {
                            "ignoreTestFailures" = {
                              "description" = "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an upgrade action but fail. Defaults to 'Test.IgnoreFailures'."
                              "type"        = "boolean"
                            }
                            "remediateLastFailure" = {
                              "description" = "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false' unless 'Retries' is greater than 0."
                              "type"        = "boolean"
                            }
                            "retries" = {
                              "description" = "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using 'Strategy', is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."
                              "type"        = "integer"
                            }
                            "strategy" = {
                              "description" = "Strategy to use for failure remediation. Defaults to 'rollback'."
                              "enum" = [
                                "rollback",
                                "uninstall",
                              ]
                              "type" = "string"
                            }
                          }
                          "type" = "object"
                        }
                        "timeout" = {
                          "description" = "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm upgrade action. Defaults to 'HelmReleaseSpec.Timeout'."
                          "type"        = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "values" = {
                      "description"                          = "Values holds the values for this Helm release."
                      "x-kubernetes-preserve-unknown-fields" = true
                    }
                    "valuesFrom" = {
                      "description" = "ValuesFrom holds references to resources containing Helm values for this HelmRelease, and information about how they should be merged."
                      "items" = {
                        "description" = "ValuesReference contains a reference to a resource containing Helm values, and optionally the key they can be found at."
                        "properties" = {
                          "kind" = {
                            "description" = "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."
                            "enum" = [
                              "Secret",
                              "ConfigMap",
                            ]
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "Name of the values referent. Should reside in the same namespace as the referring resource."
                            "maxLength"   = 253
                            "minLength"   = 1
                            "type"        = "string"
                          }
                          "optional" = {
                            "description" = "Optional marks this ValuesReference as optional. When set, a not found error for the values reference is ignored, but any ValuesKey, TargetPath or transient error will still result in a reconciliation failure."
                            "type"        = "boolean"
                          }
                          "targetPath" = {
                            "description" = "TargetPath is the YAML dot notation path the value should be merged at. When set, the ValuesKey is expected to be a single flat value. Defaults to 'None', which results in the values getting merged at the root."
                            "type"        = "string"
                          }
                          "valuesKey" = {
                            "description" = "ValuesKey is the data key where the values.yaml or a specific value can be found at. Defaults to 'values.yaml'."
                            "type"        = "string"
                          }
                        }
                        "required" = [
                          "kind",
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                  }
                  "required" = [
                    "chart",
                    "interval",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "HelmReleaseStatus defines the observed state of a HelmRelease."
                  "properties" = {
                    "conditions" = {
                      "description" = "Conditions holds the conditions for the HelmRelease."
                      "items" = {
                        "description" = "Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` \n     // other fields }"
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
                            "format"      = "date-time"
                            "type"        = "string"
                          }
                          "message" = {
                            "description" = "message is a human readable message indicating details about the transition. This may be an empty string."
                            "maxLength"   = 32768
                            "type"        = "string"
                          }
                          "observedGeneration" = {
                            "description" = "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
                            "format"      = "int64"
                            "minimum"     = 0
                            "type"        = "integer"
                          }
                          "reason" = {
                            "description" = "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
                            "maxLength"   = 1024
                            "minLength"   = 1
                            "pattern"     = "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
                            "type"        = "string"
                          }
                          "status" = {
                            "description" = "status of the condition, one of True, False, Unknown."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
                            "maxLength"   = 316
                            "pattern"     = "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
                            "type"        = "string"
                          }
                        }
                        "required" = [
                          "lastTransitionTime",
                          "message",
                          "reason",
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "failures" = {
                      "description" = "Failures is the reconciliation failure count against the latest desired state. It is reset after a successful reconciliation."
                      "format"      = "int64"
                      "type"        = "integer"
                    }
                    "helmChart" = {
                      "description" = "HelmChart is the namespaced name of the HelmChart resource created by the controller for the HelmRelease."
                      "type"        = "string"
                    }
                    "installFailures" = {
                      "description" = "InstallFailures is the install failure count against the latest desired state. It is reset after a successful reconciliation."
                      "format"      = "int64"
                      "type"        = "integer"
                    }
                    "lastAppliedRevision" = {
                      "description" = "LastAppliedRevision is the revision of the last successfully applied source."
                      "type"        = "string"
                    }
                    "lastAttemptedRevision" = {
                      "description" = "LastAttemptedRevision is the revision of the last reconciliation attempt."
                      "type"        = "string"
                    }
                    "lastAttemptedValuesChecksum" = {
                      "description" = "LastAttemptedValuesChecksum is the SHA1 checksum of the values of the last reconciliation attempt."
                      "type"        = "string"
                    }
                    "lastHandledReconcileAt" = {
                      "description" = "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change can be detected."
                      "type"        = "string"
                    }
                    "lastReleaseRevision" = {
                      "description" = "LastReleaseRevision is the revision of the last successful Helm release."
                      "type"        = "integer"
                    }
                    "observedGeneration" = {
                      "description" = "ObservedGeneration is the last observed generation."
                      "format"      = "int64"
                      "type"        = "integer"
                    }
                    "upgradeFailures" = {
                      "description" = "UpgradeFailures is the upgrade failure count against the latest desired state. It is reset after a successful reconciliation."
                      "format"      = "int64"
                      "type"        = "integer"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
