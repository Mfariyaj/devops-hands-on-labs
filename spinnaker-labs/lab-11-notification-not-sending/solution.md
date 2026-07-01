# Lab 11: Solution — Notification Not Sending

## Root Cause

1. **Invalid Slack token**: `xoxb-PLACEHOLDER-TOKEN-REPLACE-ME-12345` is not a real bot token
2. **Channel name with #**: Slack API expects just `deployments`, not `#deployments`
3. **Wrong stage for failure notification**: The `stage.failed` notification is on the Wait stage (which almost never fails) instead of the Deploy stage

## Step-by-Step Fix

### Fix 1: Set valid Slack bot token in echo-local.yml
```yaml
slack:
  enabled: true
  botName: spinnaker-bot
  token: xoxb-your-real-slack-bot-token-here
```

### Fix 2: Remove # from channel name in pipeline.json
```json
{
  "address": "deployments"
}
```

### Fix 3: Move failure notification to Deploy stage
Move the `notifications` block from the Wait stage to the Deploy stage:
```json
{
  "type": "deployManifest",
  "name": "Deploy to Production",
  "notifications": [
    {
      "type": "slack",
      "address": "deployments",
      "level": "stage",
      "when": ["stage.failed"],
      "message": {
        "stage.failed": {
          "text": "ALERT: Deployment to production FAILED!"
        }
      }
    }
  ]
}
```

Or use pipeline-level notification for failures:
```json
{
  "notifications": [
    {
      "type": "slack",
      "address": "deployments",
      "level": "pipeline",
      "when": ["pipeline.starting", "pipeline.complete", "pipeline.failed"]
    }
  ]
}
```

## Verification

```bash
# Restart Echo to pick up new token
kubectl rollout restart deployment spin-echo -n spinnaker

# Test Slack token
curl -H "Authorization: Bearer xoxb-real-token" https://slack.com/api/auth.test

# Execute pipeline and check for notification
spin pipeline execute --name "Deploy with Notifications" --application myapp

# Check Echo logs
kubectl logs -n spinnaker spin-echo-xxx | grep -i "slack\|notification" | tail -10
```

## Key Takeaways

- Slack bot tokens start with `xoxb-` — validate with `auth.test` API
- Channel names in Spinnaker notifications should NOT include the `#` prefix
- Stage notifications only fire for that specific stage's events
- Pipeline-level notifications catch all pipeline events (start, complete, fail)
- For deployment failures, put notifications on the Deploy stage or use pipeline-level `pipeline.failed`
