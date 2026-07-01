#!/bin/bash
# Lab 03: Pipeline Expression Error - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 03: Pipeline Expression Error"
echo "=============================================="
echo ""
echo "  Scenario: A pipeline uses SpEL expressions for"
echo "  dynamic configuration. Three expressions have"
echo "  syntax errors causing immediate failure."
echo ""
echo "  Your task: Fix the SpEL expressions in pipeline.json"
echo "  so the pipeline can execute successfully."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-03"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"

echo "📁 Broken pipeline deployed to: $LAB_DIR/pipeline.json"
echo ""
echo "  To upload to Spinnaker:"
echo "    spin pipeline save --file $LAB_DIR/pipeline.json"
echo ""
echo "  To trigger and observe the error:"
echo "    spin pipeline execute --name 'Deploy Service' --application myapp"
echo ""
echo "  Look for expression errors in the first stage"
echo ""
