# Lab 06: Solution — Blue-Green Rollback

## Root Cause

1. **Shrink Cluster destroys rollback target**: `allowDeleteActive: true` + `shrinkToSize: 1` means only the newest server group survives — the previous one is deleted
2. **Wrong cluster name in Rollback stage**: Uses `myapp-prod` instead of `myapp-production`
3. **maxRemainingAsgs too low**: Set to 1, which means deploy stage itself only keeps 1 server group

## Step-by-Step Fix

### Fix 1: Fix cluster name in Rollback stage
```json
"cluster": "myapp-production"
```

### Fix 2: Fix Shrink Cluster stage (or remove it)

Option A — Remove the Shrink Cluster stage entirely (safest for rollback):
Delete the stage with refId "2" and update requisiteStageRefIds.

Option B — Preserve previous version:
```json
{
  "type": "shrinkCluster",
  "name": "Cleanup Old Versions",
  "allowDeleteActive": false,
  "retainLargerOverNewer": true,
  "shrinkToSize": 2
}
```

### Fix 3: Increase maxRemainingAsgs in deploy stage
```json
"maxRemainingAsgs": 2
```

### Apply fixes
```bash
spin pipeline save --file pipeline.json
```

## Corrected Pipeline (key sections)

```json
{
  "clusters": [{
    "maxRemainingAsgs": 2,
    "scaleDown": true,
    "rollback": {
      "onFailure": true
    }
  }]
},
{
  "type": "shrinkCluster",
  "allowDeleteActive": false,
  "retainLargerOverNewer": true,
  "shrinkToSize": 2
},
{
  "type": "rollbackCluster",
  "cluster": "myapp-production",
  "targetHealthyRollbackPercentage": 95
}
```

## Verification

```bash
# After deploying twice, verify two server groups exist
curl http://localhost:8084/applications/myapp/serverGroups | \
  jq '[.[] | select(.cluster == "myapp-production")] | length'
# Should be 2

# Trigger rollback
spin pipeline execute --name "Red/Black Deploy with Rollback" \
  --application myapp --parameter-file <(echo '{"rollback":"true"}')

# Verify rollback succeeded
kubectl get replicasets -n production -l app=myapp
```

## Key Takeaways

- Red/Black requires at least 2 server groups to support rollback
- `allowDeleteActive: true` in shrink stages destroys rollback targets
- `maxRemainingAsgs` must be ≥ 2 if you want rollback capability
- Cluster names follow the pattern `{app}-{stack}-{detail}` — match exactly
- Consider enabling `rollback.onFailure: true` in the deploy stage for automatic rollback
