# Lab 04: Solution — Deploy Manifest Stage

## Root Cause

Three issues prevent the Deploy Manifest stage from executing:

1. **Artifact ID mismatch**: The stage's `manifestArtifactId` and `requiredArtifactIds` reference `artifact-abc123-deploy-manifest`, but the pipeline's `expectedArtifacts` defines the artifact with ID `artifact-xyz789-github-file`
2. **Wrong file path**: The artifact reference points to `deploy/k8s/deployment.yml` but the actual file is `k8s/deployment.yaml` (wrong directory and extension)
3. **Namespace doesn't exist**: `production-ns` namespace is used as `namespaceOverride` but hasn't been created

## Step-by-Step Fix

### Fix 1: Correct artifact IDs in the Deploy stage

```json
{
  "manifestArtifactId": "artifact-xyz789-github-file",
  "requiredArtifactIds": [
    "artifact-xyz789-github-file"
  ]
}
```

### Fix 2: Correct the file path in expectedArtifacts

```json
{
  "matchArtifact": {
    "type": "github/file",
    "reference": "https://api.github.com/repos/myorg/myapp/contents/k8s/deployment.yaml"
  },
  "defaultArtifact": {
    "type": "github/file",
    "reference": "https://api.github.com/repos/myorg/myapp/contents/k8s/deployment.yaml",
    "version": "main"
  }
}
```

### Fix 3: Create the namespace or fix the override

Option A — Create the namespace:
```bash
kubectl create namespace production-ns
```

Option B — Change to an existing namespace in the pipeline:
```json
{
  "namespaceOverride": "production"
}
```

### Apply the fix
```bash
# Save corrected pipeline
spin pipeline save --file pipeline.json

# Create namespace if needed
kubectl create namespace production-ns

# Execute pipeline
spin pipeline execute --name "Deploy Production" --application myapp
```

## Verification

```bash
# Check pipeline execution
spin pipeline execution list --application myapp --pipeline-name "Deploy Production"

# Verify deployment was created
kubectl get deployment myapp -n production-ns

# Check Orca logs for successful artifact resolution
kubectl logs -n spinnaker spin-orca-xxx | grep "artifact" | tail -5
```

## Key Takeaways

- Artifact IDs must be consistent between `expectedArtifacts`, `manifestArtifactId`, and `requiredArtifactIds`
- GitHub artifact references must exactly match the file path (case-sensitive, correct extension)
- `namespaceOverride` overrides whatever namespace is in the manifest YAML
- Use `spin pipeline get` + `jq` to inspect artifact IDs quickly
- The artifact system is Spinnaker's most confusing feature — diagram the flow when debugging
