# Lab 13: Solution — Spinnaker Operator Crash

## Root Cause

1. **Redis replicas: 0**: No Redis pod runs, causing all services to fail connecting
2. **Redis password mismatch**: SpinnakerService configures `password: spinnaker-secret-password` but Redis runs without `--requirepass`
3. **CR structure wrong**: Config is placed directly under `spec.spinnakerConfig` instead of `spec.spinnakerConfig.config`
4. **MinIO pathStyleAccess**: Should be `true` for MinIO (path-style), not `false` (virtual-hosted-style)

## Step-by-Step Fix

### Fix 1: Redis deployment — set replicas and enable password
```yaml
spec:
  replicas: 1
  template:
    spec:
      containers:
        - name: redis
          command: ["redis-server", "--requirepass", "spinnaker-secret-password"]
```

### Fix 2: Fix SpinnakerService CR structure
```yaml
spec:
  spinnakerConfig:
    config:  # <-- Add this key
      version: 1.32.0
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: spinnaker-data
          endpoint: http://minio.spinnaker:9000
          pathStyleAccess: true  # <-- Fix for MinIO
          accessKeyId: minioadmin
          secretAccessKey: minioadmin
          rootFolder: front50
```

### Fix 3: Ensure MinIO bucket exists
```bash
# Port-forward MinIO
kubectl port-forward -n spinnaker svc/minio 9000:9000

# Create bucket using MinIO client
mc alias set myminio http://localhost:9000 minioadmin minioadmin
mc mb myminio/spinnaker-data
```

### Apply fixes
```bash
kubectl apply -f redis-deployment.yaml
kubectl apply -f spinnakerservice.yaml

# Wait for reconciliation
kubectl get spinnakerservice spinnaker -n spinnaker -w
```

## Verification

```bash
# Check Redis is running
kubectl get pods -n spinnaker | grep redis
kubectl exec -n spinnaker spin-redis-0 -- redis-cli -a spinnaker-secret-password ping
# Should return: PONG

# Check all pods are running
kubectl get pods -n spinnaker
# All should be Running/Ready

# Check SpinnakerService conditions
kubectl get spinnakerservice spinnaker -n spinnaker -o jsonpath='{.status.conditions}'

# Access Deck
kubectl port-forward -n spinnaker svc/spin-deck 9000:9000
# Open http://localhost:9000
```

## Key Takeaways

- The Spinnaker Operator is strict about CR structure — always nest config under `spec.spinnakerConfig.config`
- Redis is critical — if Redis is down, ALL Spinnaker services fail
- MinIO requires `pathStyleAccess: true` (unlike real S3 which uses virtual-hosted-style)
- Always check `kubectl describe spinnakerservice` for operator-reported validation errors
- Operator logs show reconciliation errors: `kubectl logs deployment/spinnaker-operator`
