# Lab 05: Solution — Canary Analysis Failure

## Root Cause

Three issues cause canary analysis to always fail:

1. **Wrong metrics account name**: Pipeline references `my-prometheus` but the configured account is `prometheus-prod`
2. **Deprecated metric label**: Queries use `pod_name` which was deprecated in Kubernetes 1.16+; the correct label is `pod`
3. **Impossible pass threshold**: Score threshold is set to `100`, but statistical tests always have some variance — a score of 95+ is excellent, 75+ is passing

## Step-by-Step Fix

### Fix 1: Correct the metrics account name in pipeline.json

```json
"metricsAccountName": "prometheus-prod"
```

### Fix 2: Update metric queries in canary-config.json

Replace all instances of `pod_name` with `pod`:

```json
"customInlineTemplate": "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket{pod=~\"${scope}.*\",namespace=\"${location}\"}[1m])) by (le))"
```

```json
"customInlineTemplate": "sum(rate(http_requests_total{pod=~\"${scope}.*\",namespace=\"${location}\",status=~\"5..\"}[1m])) / sum(rate(http_requests_total{pod=~\"${scope}.*\",namespace=\"${location}\"}[1m]))"
```

```json
"customInlineTemplate": "avg(rate(container_cpu_usage_seconds_total{pod=~\"${scope}.*\",namespace=\"${location}\"}[1m]))"
```

### Fix 3: Lower the pass threshold

```json
"scoreThresholds": {
  "marginal": "50",
  "pass": "75"
}
```

### Apply fixes
```bash
# Save canary config
curl -X PUT http://localhost:8084/v2/canaries/canaryConfig/canary-config-broken-01 \
  -H "Content-Type: application/json" \
  -d @canary-config.json

# Save pipeline
spin pipeline save --file pipeline.json

# Re-execute
spin pipeline execute --name "Canary Deploy" --application myapp
```

## Verification

```bash
# Check Kayenta can now query metrics
kubectl logs -n spinnaker spin-kayenta-xxx | grep -i "prometheus" | tail -10

# Verify no "account not found" errors
kubectl logs -n spinnaker spin-kayenta-xxx | grep -i "error" | tail -5

# After execution, check canary report
curl http://localhost:8084/v2/canaries/canary/<execution-id> | jq '.result.overallScore'
# Should be > 0 (ideally 75+ for identical versions)

# Verify Prometheus queries work
curl 'http://prometheus:9090/api/v1/query?query=rate(http_request_duration_seconds_bucket{pod=~"myapp-canary.*"}[1m])'
```

## Key Takeaways

- Metrics account names must exactly match Kayenta's configuration
- Kubernetes metric labels change between versions — verify with actual Prometheus queries
- Never set pass threshold to 100 — statistical analysis has inherent variance (75 is standard)
- Test metric queries against Prometheus directly before using them in canary configs
- The `nanStrategy` setting matters: "replace" (with 0) vs "remove" (drop data point) affects scoring
