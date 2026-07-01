# Lab 08: Solution — Pipeline Template Broken

## Root Cause

1. **Wrong variable reference**: Template uses `{{ templateVariables.cluster }}` but the variable is defined as `targetCluster`
2. **Type mismatch**: Instance provides `"replicas": "3"` (string) but template declares it as `"type": "int"`
3. **Missing module**: Template references `spinnaker://notifications-module` which doesn't exist

## Step-by-Step Fix

### Fix 1: Correct variable name in template

In `pipeline-template.json`, change all occurrences of `{{ templateVariables.cluster }}` to `{{ templateVariables.targetCluster }}`:

```json
"account": "{{ templateVariables.targetCluster }}"
```

### Fix 2: Fix type in instance

In `pipeline-instance.json`, change replicas from string to integer:
```json
"replicas": 3
```

### Fix 3: Remove or replace module reference

Option A — Remove the module stage:
```json
// Delete the stage with "type": "module" 
```

Option B — Inline the notification logic:
```json
{
  "type": "webhook",
  "name": "Send Notifications",
  "refId": "3",
  "requisiteStageRefIds": ["2"],
  "url": "https://hooks.slack.com/services/XXX/YYY/ZZZ",
  "method": "POST",
  "payload": {
    "text": "Deployment complete: {{ templateVariables.application }} to {{ templateVariables.namespace }}"
  }
}
```

### Apply fixes
```bash
# Save corrected template
spin pipeline-template save --file pipeline-template.json

# Plan (dry-run) the instance
spin pipeline-template plan --file pipeline-instance.json

# Save the instance as a pipeline
spin pipeline save --file pipeline-instance.json
```

## Verification

```bash
# Validate template
spin pipeline-template get --id deploy-standard-v2

# Plan instance (should show no errors)
spin pipeline-template plan --file pipeline-instance.json

# Save and execute
spin pipeline save --file pipeline-instance.json
spin pipeline execute --name "Deploy Myapp to Production" --application myapp
```

## Key Takeaways

- Template variable references must exactly match the `name` field in the variables array
- Variables are typed — `int` variables must receive integer values, not strings
- Modules must exist in Front50 before templates can reference them
- Use `spin pipeline-template plan` to validate before saving
- The Jinja-style `{{ }}` syntax is used for template rendering (different from SpEL `${ }`)
