# Lab 02: Solution — Clouddriver K8s Account

## Root Cause

Three separate issues prevent Clouddriver from connecting to Kubernetes:

1. **Context name mismatch**: `clouddriver-local.yml` references context `production-cluster`, but the kubeconfig only defines `prod-cluster`
2. **Missing ClusterRoleBinding**: The service account `spinnaker-deployer` has no ClusterRoleBinding, so even with a valid token, all API requests return 401/403
3. **Wrong API server port**: Kubeconfig has `server: https://10.0.1.100:64430` but the correct port is `6443`

## Step-by-Step Fix

### Fix 1: Correct the context name in clouddriver-local.yml

```yaml
# Change from:
context: production-cluster
# To:
context: prod-cluster
```

### Fix 2: Fix the server URL in kubeconfig

```yaml
# Change from:
server: https://10.0.1.100:64430
# To:
server: https://10.0.1.100:6443
```

### Fix 3: Create the missing ClusterRoleBinding

```bash
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: spinnaker-deployer-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spinnaker-deployer-role
subjects:
  - kind: ServiceAccount
    name: spinnaker-deployer
    namespace: spinnaker
EOF
```

### Apply changes
```bash
# Apply RBAC
kubectl apply -f rbac.yaml
kubectl apply -f clusterrolebinding.yaml

# Update Halyard
hal config provider kubernetes account edit my-k8s-account \
  --context prod-cluster

# Redeploy
hal deploy apply

# Or restart Clouddriver
kubectl rollout restart deployment spin-clouddriver -n spinnaker
```

## Corrected clouddriver-local.yml

```yaml
kubernetes:
  enabled: true
  accounts:
    - name: my-k8s-account
      providerVersion: V2
      serviceAccount: false
      context: prod-cluster
      kubeconfigFile: /opt/spinnaker/credentials/kubeconfig
      namespaces:
        - default
        - production
        - staging
      omitNamespaces:
        - kube-system
        - kube-public
      kinds:
        - deployment
        - replicaSet
        - service
        - ingress
        - configMap
        - secret
      liveManifestCalls: true
  primaryAccount: my-k8s-account
```

## Verification

```bash
# Check Clouddriver logs for successful caching
kubectl logs -n spinnaker spin-clouddriver-xxx | grep -i "caching"
# Should see: "Caching all resources for account my-k8s-account"

# Verify permissions work
kubectl auth can-i list deployments \
  --as=system:serviceaccount:spinnaker:spinnaker-deployer

# Check Spinnaker sees resources
spin application list

# Verify via API
curl http://localhost:8084/credentials | jq '.[].name'
# Should include "my-k8s-account"
```

## Key Takeaways

- Context names in clouddriver config MUST exactly match the kubeconfig
- RBAC requires all three parts: ServiceAccount + ClusterRole + ClusterRoleBinding
- Kubernetes API server default port is 6443
- Use `kubectl auth can-i` to test service account permissions
- Clouddriver caches resources asynchronously — check logs for caching activity
