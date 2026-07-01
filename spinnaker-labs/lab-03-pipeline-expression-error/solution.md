# Lab 03: Solution — Pipeline Expression Error

## Root Cause

Three SpEL expression bugs in the pipeline:

1. **`trigger.parameter.environment`** — should be `trigger.parameters.environment` (plural 's')
   - The trigger parameters map is called `parameters`, not `parameter`

2. **`#stage(Build Docker).outputs.image`** — should be `#stage('Build Docker').outputs.image`
   - The `#stage()` helper function requires a quoted string argument
   - Without quotes, "Build Docker" is parsed as two tokens causing a parse error

3. **`deployResult.status = 'SUCCEEDED'`** — should use `==` for comparison
   - Single `=` is assignment, double `==` is comparison
   - Also `deployResult` isn't a valid variable — should reference a stage

## Step-by-Step Fix

### Fix 1: Correct trigger.parameters (add 's')

In the "Determine Environment" stage variables:
```json
{
  "key": "targetNamespace",
  "value": "${trigger.parameters.environment}"
},
{
  "key": "deployRegion", 
  "value": "${trigger.parameters.environment == 'production' ? 'us-east-1' : 'us-west-2'}"
}
```

### Fix 2: Add quotes around stage name

In the "Deploy to Kubernetes" stage container image:
```json
"image": "${#stage('Build Docker').outputs.image}"
```

### Fix 3: Use == and fix variable reference

In the "Send Notification" stage payload:
```json
"payload": {
  "text": "Deployment ${#stage('Deploy to Kubernetes').status == 'SUCCEEDED' ? 'completed' : 'failed'} for ${trigger.parameters.environment}"
}
```

### Apply the fix
```bash
# Edit pipeline.json with the fixes, then save
spin pipeline save --file pipeline.json

# Re-execute
spin pipeline execute --name "Deploy Service" --application myapp \
  --parameter-file <(echo '{"environment":"staging","imageTag":"v1.2.3"}')
```

## Corrected Expressions Summary

| Location | Broken | Fixed |
|----------|--------|-------|
| Stage 1 variable | `${trigger.parameter.environment}` | `${trigger.parameters.environment}` |
| Stage 3 image | `${#stage(Build Docker).outputs.image}` | `${#stage('Build Docker').outputs.image}` |
| Stage 5 payload | `${deployResult.status = 'SUCCEEDED'}` | `${#stage('Deploy to Kubernetes').status == 'SUCCEEDED'}` |

## Verification

```bash
# Save fixed pipeline
spin pipeline save --file pipeline.json

# Execute with parameters
spin pipeline execute --name "Deploy Service" --application myapp

# Check execution status
spin pipeline execution list --application myapp --pipeline-name "Deploy Service"

# Verify no expression errors in Orca
kubectl logs -n spinnaker spin-orca-xxx | grep -i "expression" | tail -5
```

## Key Takeaways

- `trigger.parameters` (plural) is the correct property for pipeline parameters
- Stage name references in `#stage()` MUST be quoted strings
- Use `==` for comparison, `=` is assignment (which SpEL blocks for safety)
- Use the SpEL evaluation endpoint to test expressions before committing them
- Always check Orca logs for detailed expression error messages
