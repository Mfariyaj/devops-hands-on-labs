#!/bin/bash
# Lab 01: Halyard Config Broken - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LAB_NAME="lab-01-halyard-config-broken"

echo "=============================================="
echo "  🎯 Spinnaker Lab 01: Halyard Config Broken"
echo "=============================================="
echo ""
echo "  Scenario: You're setting up Spinnaker with Halyard."
echo "  A colleague partially configured it but the storage"
echo "  backend (S3) is misconfigured. hal deploy apply fails."
echo ""
echo "  Your task: Fix the Halyard configuration so that"
echo "  the S3 storage backend is properly configured."
echo ""
echo "=============================================="
echo ""

# Create a working directory simulating ~/.hal/
HAL_DIR="/tmp/spinnaker-lab-01"
rm -rf "$HAL_DIR"
mkdir -p "$HAL_DIR"

# Copy the broken config
cp "$SCRIPT_DIR/hal-config.yml" "$HAL_DIR/config"

echo "📁 Broken Halyard config deployed to: $HAL_DIR/config"
echo ""
echo "To inspect the broken config:"
echo "  cat $HAL_DIR/config"
echo ""
echo "To simulate what 'hal deploy apply' would report:"
echo "  Look for issues in the persistentStorage section"
echo ""
echo "Fix the config and verify with:"
echo "  hal config storage s3 (after copying to ~/.hal/config)"
echo ""
