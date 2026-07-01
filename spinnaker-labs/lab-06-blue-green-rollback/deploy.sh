#!/bin/bash
# Lab 06: Blue-Green Rollback - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 06: Blue-Green Rollback"
echo "=============================================="
echo ""
echo "  Scenario: A Red/Black (Blue-Green) deployment"
echo "  completes, but the rollback stage fails when"
echo "  triggered. Previous server groups are gone."
echo ""
echo "  Your task: Fix the pipeline so rollback works."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-06"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"

echo "📁 Broken pipeline deployed to: $LAB_DIR/pipeline.json"
echo ""
echo "  Key areas to investigate:"
echo "    - Shrink Cluster stage settings"
echo "    - Rollback stage cluster name"
echo "    - maxRemainingAsgs in deploy stage"
echo ""
