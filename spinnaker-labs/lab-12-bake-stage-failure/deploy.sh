#!/bin/bash
# Lab 12: Bake Stage Failure - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 12: Bake Stage Failure"
echo "=============================================="
echo ""
echo "  Scenario: Rosco bake stage fails. Packer template"
echo "  has JSON errors, base AMI doesn't exist, and"
echo "  region configuration is mismatched."
echo ""
echo "  Your task: Fix all three issues."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-12"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/packer-template.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/rosco-local.yml" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - packer-template.json (Packer template with errors)"
echo "    - rosco-local.yml (Rosco region config)"
echo "    - pipeline.json (bake stage config)"
echo ""
