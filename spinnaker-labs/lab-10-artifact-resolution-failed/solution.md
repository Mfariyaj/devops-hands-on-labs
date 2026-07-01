# Lab 10: Solution — Artifact Resolution Failed

## Root Cause

1. **Case-sensitive type mismatch**: Expected artifact uses `Docker/Image` but Docker triggers produce `docker/image` (lowercase)
2. **Wrong branch**: GitHub artifact reference implicitly uses `master` but repo default branch is now `main`
3. **Empty default artifact**: `defaultArtifact: {}` is set but has no type or reference, causing fallback to fail

## Step-by-Step Fix

### Fix 1: Correct artifact type case
```json
{
  "matchArtifact": {
    "type": "docker/image",
    "name": "myorg/myapp"
  }
}
```

### Fix 2: Add version/branch for GitHub artifact
```json
{
  "matchArtifact": {
    "type": "github/file",
    "name": "k8s/deploy.yaml",
    "reference": "https://api.github.com/repos/myorg/myapp/contents/k8s/deploy.yaml"
  },
  "defaultArtifact": {
    "type": "github/file",
    "name": "k8s/deploy.yaml",
    "reference": "https://api.github.com/repos/myorg/myapp/contents/k8s/deploy.yaml",
    "version": "main"
  }
}
```

### Fix 3: Populate default artifact properly
```json
{
  "defaultArtifact": {
    "type": "github/file",
    "name": "k8s/deploy.yaml",
    "reference": "https://api.github.com/repos/myorg/myapp/contents/k8s/deploy.yaml",
    "version": "main"
  }
}
```

## Verification

```bash
# Save fixed pipeline
spin pipeline save --file pipeline.json

# Execute and check artifact resolution
spin pipeline execute --name "Artifact Deploy Pipeline" --application myapp

# Check execution artifacts
spin pipeline execution get --id <exec-id> | jq '.trigger.resolvedExpectedArtifacts'
```

## Key Takeaways

- Artifact types are case-sensitive — always use lowercase (`docker/image`, `github/file`, `s3/object`)
- Default artifacts MUST have `type` and `reference` fields — empty objects cause failures
- GitHub artifact `version` field specifies the branch/tag/commit
- When repos migrate from `master` to `main`, update all artifact references
- `usePriorArtifact: true` uses the artifact from the last execution as fallback (useful for re-runs)
