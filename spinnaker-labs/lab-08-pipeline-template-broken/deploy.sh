#!/bin/bash
# Lab 08: Pipeline Template Broken - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 08: Pipeline Template Broken"
echo "=============================================="
echo ""
echo "  Scenario: A MPT v2 pipeline template can't be"
echo "  instantiated. Variable references are wrong,"
echo "  types mismatch, and a module is missing."
echo ""
echo "  Your task: Fix the template and instance so"
echo "  the pipeline can be created and executed."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-08"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline-template.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/pipeline-instance.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - pipeline-template.json (template definition)"
echo "    - pipeline-instance.json (instance with variable values)"
echo ""
