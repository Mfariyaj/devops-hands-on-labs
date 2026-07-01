#!/bin/bash
# Lab 09: RBAC Fiat Denied - Deploy Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=============================================="
echo "  🎯 Spinnaker Lab 09: RBAC Fiat Denied"
echo "=============================================="
echo ""
echo "  Scenario: Users can't access applications despite"
echo "  being in the correct LDAP group. Fiat is denying"
echo "  access and pipeline triggers fail with 403."
echo ""
echo "  Your task: Fix RBAC configuration so dev-team"
echo "  members can access myapp and triggers work."
echo ""
echo "=============================================="
echo ""

LAB_DIR="/tmp/spinnaker-lab-09"
rm -rf "$LAB_DIR"
mkdir -p "$LAB_DIR"

cp "$SCRIPT_DIR/fiat-local.yml" "$LAB_DIR/"
cp "$SCRIPT_DIR/front50-local.yml" "$LAB_DIR/"
cp "$SCRIPT_DIR/application-permissions.json" "$LAB_DIR/"

echo "📁 Broken configs deployed to: $LAB_DIR/"
echo ""
echo "  Files to investigate:"
echo "    - fiat-local.yml (LDAP group search config)"
echo "    - application-permissions.json (app-level permissions)"
echo "    - front50-local.yml (metadata storage config)"
echo ""
