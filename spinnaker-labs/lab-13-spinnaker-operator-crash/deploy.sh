#!/bin/bash
# Lab 13: Spinnaker Operator Crash - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 13: Spinnaker Operator Crash"
echo "=============================================="
echo ""
echo "  Scenario: Spinnaker deployed via Operator but"
echo "  services are crash-looping. Redis unavailable,"
echo "  Front50 can't reach storage, CR has wrong structure."
echo ""
echo "  Your task: Fix all issues so Spinnaker starts."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-13"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/spinnakerservice.yaml" "$LAB_DIR/"
cp "$SCRIPT_DIR/redis-deployment.yaml" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  To deploy (if you have a cluster with the operator installed):"
echo "    kubectl apply -f $LAB_DIR/redis-deployment.yaml"
echo "    kubectl apply -f $LAB_DIR/spinnakerservice.yaml"
echo ""
echo "  Files to investigate:"
echo "    - spinnakerservice.yaml (SpinnakerService CR)"
echo "    - redis-deployment.yaml (Redis deployment)"
echo ""
