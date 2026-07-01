#!/bin/bash
# Lab 04: Deploy Manifest Stage - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 04: Deploy Manifest Stage"
echo "=============================================="
echo ""
echo "  Scenario: A Deploy Manifest stage fails because"
echo "  artifact IDs don't match, the file reference path"
echo "  is wrong, and the target namespace doesn't exist."
echo ""
echo "  Your task: Fix artifact binding and namespace config."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-04"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR/manifests"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/manifests/deployment.yaml" "$LAB_DIR/manifests/"

echo "📁 Broken pipeline deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - $LAB_DIR/pipeline.json (check expectedArtifacts and stage config)"
echo "    - $LAB_DIR/manifests/deployment.yaml (the actual manifest)"
echo ""
