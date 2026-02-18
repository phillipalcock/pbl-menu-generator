#!/bin/bash

# PBL Menu Generator — Installer for Claude Cowork
# Run this from inside the cloned repo directory

set -e

echo ""
echo "=================================="
echo "  PBL Menu Generator — Installer"
echo "=================================="
echo ""

# Create skill directory
SKILL_DIR="/mnt/skills/user/pbl-menu-generator"
mkdir -p "$SKILL_DIR"

# Copy skill file
cp skill/SKILL.md "$SKILL_DIR/SKILL.md"
echo "✓ Skill installed to $SKILL_DIR"

# Copy input template to working directory
cp templates/pbl-menu-input.md /home/claude/pbl-menu-input.md
echo "✓ Input template copied to /home/claude/pbl-menu-input.md"

# Copy example files
mkdir -p /home/claude/pbl-examples
cp examples/example-input-science.md /home/claude/pbl-examples/
cp examples/example-input-humanities.md /home/claude/pbl-examples/
echo "✓ Example input files copied to /home/claude/pbl-examples/"

# Create output directory
mkdir -p /mnt/user-data/outputs/pbl-menu/project-briefs
echo "✓ Output directory created at /mnt/user-data/outputs/pbl-menu/"

echo ""
echo "=================================="
echo "  Installation complete!"
echo "=================================="
echo ""
echo "NEXT STEPS:"
echo ""
echo "  1. Open this file in Cowork:"
echo "     /home/claude/pbl-menu-input.md"
echo ""
echo "  2. Fill in your class details (takes about 5 minutes)"
echo ""
echo "  3. In the Cowork chat, say:"
echo "     'Generate my PBL menu using the pbl-menu-generator skill'"
echo ""
echo "  4. Find your outputs at:"
echo "     /mnt/user-data/outputs/pbl-menu/"
echo ""
echo "  Need examples? See /home/claude/pbl-examples/"
echo ""
