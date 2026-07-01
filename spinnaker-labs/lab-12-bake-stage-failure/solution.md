# Lab 12: Solution — Bake Stage Failure

## Root Cause

1. **Invalid JSON**: Trailing comma after the last element in the `provisioners` array
2. **Non-existent AMI**: `ami-0123456789INVALID` doesn't exist in any region
3. **Region mismatch**: Rosco defaults to `us-east-1` but pipeline requests bake in `us-west-2`

## Step-by-Step Fix

### Fix 1: Remove trailing comma in packer-template.json

```json
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "sudo apt-get update",
        "sudo apt-get install -y myapp={{user `app_version`}}"
      ]
    },
    {
      "type": "shell",
      "inline": [
        "sudo systemctl enable myapp",
        "sudo systemctl start myapp"
      ]
    }
  ]
```
(Remove the comma after the closing `}` of the last provisioner)

### Fix 2: Use a valid base AMI

Find a real AMI for us-west-2:
```bash
aws ec2 describe-images --owners amazon \
  --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64*" \
  --region us-west-2 --query 'sort_by(Images, &CreationDate)[-1].ImageId' --output text
```

Update packer-template.json:
```json
"source_ami": "ami-0abcdef1234567890"  // Replace with real AMI from above command
```

### Fix 3: Align Rosco region with bake request

In rosco-local.yml:
```yaml
aws:
  defaultRegion: us-west-2
  bakeryDefaults:
    baseImages:
      - baseImage:
          id: ubuntu
        virtualizations:
          - region: us-west-2
            virtualizationType: hvm
            baseAmi: ami-REAL-AMI-FOR-US-WEST-2
```

### Apply and restart
```bash
# Restart Rosco
kubectl rollout restart deployment spin-rosco -n spinnaker

# Validate Packer template
packer validate packer-template.json

# Re-execute pipeline
spin pipeline execute --name "Bake and Deploy" --application myapp
```

## Verification

```bash
# Check Rosco logs for successful bake
kubectl logs -n spinnaker spin-rosco-xxx | grep -i "bake\|ami" | tail -10

# Verify AMI was created
aws ec2 describe-images --owners self \
  --filters "Name=name,Values=myapp-1.2.3-*" \
  --region us-west-2 | jq '.Images[0].ImageId'
```

## Key Takeaways

- Packer templates must be valid JSON — use `packer validate` locally before deploying
- Base AMIs are region-specific — an AMI in us-east-1 can't be used in us-west-2
- Rosco's `defaultRegion` and `baseImages[].virtualizations[].region` must match the pipeline's bake region
- Always validate Packer templates locally with `packer validate` before using in Spinnaker
