#!/bin/bash
# Cleanup all Spinnaker troubleshooting labs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🧹 Spinnaker Troubleshooting Labs - Cleanup All"
echo "=============================================="
echo ""

for lab_dir in "$SCRIPT_DIR"/lab-*/; do
    if [ -f "$lab_dir/cleanup.sh" ]; then
        lab_name=$(basename "$lab_dir")
        echo "▶ Cleaning: $lab_name"
        (cd "$lab_dir" && bash cleanup.sh)
        echo ""
    fi
done

echo "=============================================="
echo "  ✅ All labs cleaned up"
echo "=============================================="
