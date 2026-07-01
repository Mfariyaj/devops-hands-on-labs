#!/bin/bash
# Lab 07: Trigger Not Firing - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 07: Trigger Not Firing"
echo "=============================================="
echo ""
echo "  Scenario: Pipeline should auto-trigger on new"
echo "  Docker images and webhook calls, but neither works."
echo ""
echo "  Your task: Fix trigger configuration so both"
echo "  Docker Registry and Webhook triggers fire correctly."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-07"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/igor-local.yml" "$LAB_DIR/"
cp "$SCRIPT_DIR/webhook-payload.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - pipeline.json (trigger configuration)"
echo "    - igor-local.yml (Docker registry account config)"
echo "    - webhook-payload.json (sample webhook payload)"
echo ""
