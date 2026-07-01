#!/bin/bash
# Deploy all Spinnaker troubleshooting labs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Troubleshooting Labs - Deploy All"
echo "=============================================="
echo ""

for lab_dir in "$SCRIPT_DIR"/lab-*/; do
    if [ -f "$lab_dir/deploy.sh" ]; then
        lab_name=$(basename "$lab_dir")
        echo "▶ Deploying: $lab_name"
        (cd "$lab_dir" && bash deploy.sh)
        echo ""
    fi
done

echo "=============================================="
echo "  ✅ All 15 labs deployed successfully"
echo "  Use 'kubectl get pods -n spinnaker' to check status"
echo "=============================================="
