# Lab 14: Solution — Managed Pipeline Delivery

## Root Cause

1. **Constraints wrong location**: `constraints` is indented under a resource instead of being at the environment level
2. **Wrong environment reference**: `depends-on` constraint references `test` but the environment is `testing`
3. **Wrong time window format**: `days` should be a list `["Mon-Fri"]` and `hours` should be a quoted string `"9-17"`

## Step-by-Step Fix

### Fix 1 & 2 & 3: Corrected delivery-config.yml

```yaml
name: myapp
application: myapp
serviceAccount: spinnaker-managed-delivery
artifacts:
  - name: myapp-docker
    type: docker
    reference: myorg/myapp
    tagVersionStrategy:
      strategy: semver
environments:
  - name: testing
    resources:
      - kind: k8s/resource@v1
        spec:
          metadata:
            application: myapp
          template:
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: myapp
              namespace: testing
            spec:
              replicas: 2
              selector:
                matchLabels:
                  app: myapp
              template:
                metadata:
                  labels:
                    app: myapp
                spec:
                  containers:
                    - name: myapp
                      image: myorg/myapp
                      ports:
                        - containerPort: 8080
  - name: production
    # FIX 1: constraints at environment level (same indent as resources)
    constraints:
      - type: depends-on
        # FIX 2: correct environment name
        environment: testing
      - type: allowed-times
        windows:
          # FIX 3: proper format
          - days: ["Mon", "Tue", "Wed", "Thu", "Fri"]
            hours: "9-17"
    resources:
      - kind: k8s/resource@v1
        spec:
          metadata:
            application: myapp
          template:
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: myapp
              namespace: production
            spec:
              replicas: 5
              selector:
                matchLabels:
                  app: myapp
              template:
                metadata:
                  labels:
                    app: myapp
                spec:
                  containers:
                    - name: myapp
                      image: myorg/myapp
                      ports:
                        - containerPort: 8080
    verifications:
      - type: automated
        id: integration-tests
```

### Apply fix
```bash
curl -X POST http://gate:8084/managed/delivery-configs \
  -H "Content-Type: application/yaml" \
  --data-binary @delivery-config.yml
```

## Verification

```bash
# Check delivery config is valid
curl http://gate:8084/managed/application/myapp/config | jq '.status'
# Should be "OK"

# Check resource status
curl http://gate:8084/managed/resources | jq '.[].status'
# Should show "HAPPY" or "ACTUATING"

# Check constraints
curl http://gate:8084/managed/application/myapp/environment | jq '.[1].constraints'
```

## Key Takeaways

- YAML indentation is critical — `constraints` must be at environment level
- Environment names in constraints must exactly match defined environments
- `allowed-times` windows format: `days` is a list of day names, `hours` is a string "HH-HH"
- Use the validation endpoint before submitting delivery configs
- Keel (the managed delivery engine) logs show constraint evaluation details
