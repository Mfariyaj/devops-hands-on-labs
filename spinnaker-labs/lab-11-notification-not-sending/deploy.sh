#!/bin/bash
# Lab 11: Notification Not Sending - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 11: Notification Not Sending"
echo "=============================================="
echo ""
echo "  Scenario: Slack notifications aren't delivered."
echo "  Token is invalid, channel name is wrong, and"
echo "  the failure notification is on the wrong stage."
echo ""
echo "  Your task: Fix notification configuration."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-11"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/pipeline.json" "$LAB_DIR/"
cp "$SCRIPT_DIR/echo-local.yml" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - pipeline.json (notification configuration)"
echo "    - echo-local.yml (Slack token and settings)"
echo ""
