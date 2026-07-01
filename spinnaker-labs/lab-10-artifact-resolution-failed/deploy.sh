#!/bin/bash
# Lab 10: Artifact Resolution Failed - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 10: Artifact Resolution Failed"
echo "=============================================="
echo ""
echo "  Scenario: Pipeline can't resolve artifacts."
echo "  Docker image type case mismatch, GitHub branch"
echo "  wrong, and default artifact is empty."
echo ""
echo "  Your task: Fix artifact configuration so"
echo "  binding and resolution work correctly."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-10"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/artifact-config.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - pipeline.json (expectedArtifacts and trigger config)"
echo "    - artifact-config.json (reference information)"
echo ""
