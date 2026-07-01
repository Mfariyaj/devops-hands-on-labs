#!/bin/bash
# Lab 05: Canary Analysis Failure - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 05: Canary Analysis Failure"
echo "=============================================="
echo ""
echo "  Scenario: Kayenta automated canary analysis"
echo "  always reports failure even when the canary"
echo "  version is identical to baseline."
echo ""
echo "  Your task: Fix the canary configuration so"
echo "  metrics are properly queried and scoring works."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-05"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/canary-config.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - $LAB_DIR/pipeline.json (canary pipeline with kayentaCanary stage)"
echo "    - $LAB_DIR/canary-config.json (canary analysis config)"
echo ""
