#!/bin/bash
echo "🧹 Cleaning up Lab 10: RBAC Policy"
kubectl delete application rbac-test-app -n argocd --ignore-not-found
kubectl delete appproject team-project -n argocd --ignore-not-found

# IMPORTANT: Restore default RBAC policy so ArgoCD UI works again
kubectl apply -n argocd -f - <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-rbac-cm
  namespace: argocd
data:
  policy.default: role:admin
YAML

echo "✅ Cleanup complete (RBAC restored to default)"
