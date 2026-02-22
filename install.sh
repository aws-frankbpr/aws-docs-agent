#!/bin/bash

set -e

echo "========================================="
echo "AWS Documentation Agent Installer"
echo "========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v kiro-cli &> /dev/null; then
    echo "❌ Kiro CLI not found. Install from: https://github.com/aws/kiro-cli"
    exit 1
fi
echo "✓ Kiro CLI found"

if ! command -v uv &> /dev/null; then
    echo "❌ uv not found. Install from: https://docs.astral.sh/uv/"
    exit 1
fi
echo "✓ uv found"

if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found"
    exit 1
fi
echo "✓ Python 3 found"

# Test MCP server
echo ""
echo "Testing MCP server..."
if ! timeout 5 uvx --version &> /dev/null; then
    echo "❌ uvx not working properly"
    exit 1
fi
echo "✓ uvx working"

# Create directories
echo ""
echo "Creating directories..."
mkdir -p ~/.kiro/agents ~/.kiro/prompts ~/.kiro/settings
echo "✓ Directories created"

# Install files
echo ""
echo "Installing agents..."
cp agents/*.json ~/.kiro/agents/
cp prompts/*.md ~/.kiro/prompts/
echo "✓ Agents installed"

# Configure MCP
echo ""
echo "Configuring MCP server..."

if [ -f ~/.kiro/settings/mcp.json ]; then
    echo "⚠️  MCP config exists"
    read -p "Update AWS Documentation MCP server? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp ~/.kiro/settings/mcp.json ~/.kiro/settings/mcp.json.backup.$(date +%s)
        python3 -c '
import json, os
path = os.path.expanduser("~/.kiro/settings/mcp.json")
with open(path) as f: config = json.load(f)
config["awslabs.aws-documentation-mcp-server"] = {
    "command": "uvx",
    "args": ["awslabs.aws-documentation-mcp-server@latest"],
    "env": {}
}
with open(path, "w") as f: json.dump(config, f, indent=2)
'
        echo "✓ MCP server updated"
    fi
else
    cat > ~/.kiro/settings/mcp.json << 'EOF'
{
  "awslabs.aws-documentation-mcp-server": {
    "command": "uvx",
    "args": ["awslabs.aws-documentation-mcp-server@latest"],
    "env": {}
  }
}
EOF
    echo "✓ MCP server configured"
fi

# Verify
echo ""
echo "Verifying installation..."
sleep 1

if kiro-cli agent list 2>&1 | grep -q "aws-docs-agent"; then
    echo ""
    echo "========================================="
    echo "✓ Installation Complete!"
    echo "========================================="
    echo ""
    echo "Usage:"
    echo "  kiro-cli chat --agent aws-docs-agent"
    echo ""
else
    echo ""
    echo "⚠️  Agents installed but not showing in list"
    echo "Try: kiro-cli agent list | grep aws-docs"
fi
