# Lab 01: Solution — Halyard Config Broken

## Root Cause

The Halyard configuration file (`~/.hal/config`) has multiple issues in the `persistentStorage.s3` section:

1. **Invalid bucket name**: `spinnaker-data-bucket-CHANGEME` — this bucket doesn't exist in AWS
2. **Invalid region**: `us-north-1` — this is not a valid AWS region
3. **Placeholder credentials**: `AKIA_PLACEHOLDER_KEY` / `wJalrXUtnFEMI/PLACEHOLDER/SECRET+KEY` are not real AWS credentials
4. **Wrong root folder**: `frnt50` (typo) should be `front50`

## Step-by-Step Fix

### Step 1: Create or identify a valid S3 bucket
```bash
# Create a bucket (or use an existing one)
aws s3 mb s3://my-spinnaker-storage --region us-east-1
```

### Step 2: Fix the region
```bash
hal config storage s3 edit --region us-east-1
```

### Step 3: Fix the bucket name
```bash
hal config storage s3 edit --bucket my-spinnaker-storage
```

### Step 4: Fix credentials (use one of these approaches)

Option A — Use IAM instance profile (recommended for EC2/EKS):
```bash
# Remove explicit credentials, let instance profile handle it
# Edit ~/.hal/config and remove accessKeyId and secretAccessKey
```

Option B — Use valid AWS credentials:
```bash
hal config storage s3 edit \
  --access-key-id AKIAIOSFODNN7EXAMPLE \
  --secret-access-key
# (it will prompt for the secret key)
```

### Step 5: Fix root folder
```bash
hal config storage s3 edit --root-folder front50
```

### Step 6: Validate and apply
```bash
hal config
hal deploy apply
```

## Corrected Configuration

```yaml
persistentStorage:
  persistentStoreType: s3
  s3:
    bucket: my-spinnaker-storage
    region: us-east-1
    rootFolder: front50
    # Using IAM instance profile - no explicit keys needed
    # Or provide valid accessKeyId and secretAccessKey
    pathStyleAccess: false
```

## Verification

```bash
# Validate Halyard config
hal config storage s3

# Should show:
#   bucket: my-spinnaker-storage
#   region: us-east-1
#   rootFolder: front50

# Apply deployment
hal deploy apply

# Check Front50 health
kubectl get pods -n spinnaker | grep front50
kubectl logs -n spinnaker spin-front50-xxx | grep -i "started"

# Test Front50 connectivity to S3
kubectl exec -n spinnaker spin-front50-xxx -- \
  curl -s localhost:8080/health | jq .status
# Should return "UP"
```

## Key Takeaways

- Halyard validates storage config before deploying — always run `hal config` first
- S3 region must match where the bucket was created
- IAM instance profiles are preferred over hardcoded credentials
- Front50 is the first service to fail when storage is misconfigured
- The `rootFolder` setting determines the prefix path in S3 for all Spinnaker data
