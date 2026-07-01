# Lab 07: Solution — Trigger Not Firing

## Root Cause

1. **Docker account name mismatch**: Igor has `docker-hub` but pipeline trigger uses `dockerhub`
2. **Webhook source mismatch**: Trigger expects `github-deploy` (hyphen) but payload sends to `github_deploy` (underscore)
3. **Tag pattern mismatch**: Regex `v[0-9]+\.[0-9]+\.[0-9]+` expects `v1.2.3` format but actual tags are `release-1.2.3`

## Step-by-Step Fix

### Fix 1: Match Docker account name
```json
{
  "type": "docker",
  "account": "docker-hub"
}
```

### Fix 2: Match webhook source
Either change the pipeline trigger:
```json
{
  "type": "webhook",
  "source": "github_deploy"
}
```
Or change the webhook sender URL to use hyphen: `/webhooks/webhook/github-deploy`

### Fix 3: Fix tag pattern regex
```json
{
  "tag": "release-[0-9]+\\.[0-9]+\\.[0-9]+"
}
```

### Apply
```bash
spin pipeline save --file pipeline.json
```

## Verification

```bash
# Test Docker trigger - push a matching image
docker push myorg/myapp:release-1.2.4

# Check Igor detects it
kubectl logs -n spinnaker spin-igor-xxx | grep "release-1.2.4"

# Test webhook
curl -X POST http://localhost:8084/webhooks/webhook/github_deploy \
  -H "Content-Type: application/json" \
  -d @webhook-payload.json

# Verify pipeline started
spin pipeline execution list --application myapp --pipeline-name "Auto Deploy"
```

## Key Takeaways

- Docker Registry account names are exact-match — hyphens/underscores matter
- Webhook source determines the URL path: `source: X` → `/webhooks/webhook/X`
- Tag patterns are Java regex — test them against actual tag formats
- Igor polls at configurable intervals (default 30s) — there may be a delay
- Use Echo logs to trace event routing from Igor → Echo → Orca
