#!/bin/bash

set -e

echo "========================================="
echo "AWS Documentation Agent Installer"
echo "========================================="
echo ""

# Check prerequisites
echo "Checking prerequisites..."

if ! command -v kiro-cli &> /dev/null; then
    echo "❌ Kiro CLI not found. Please install from: https://github.com/aws/kiro-cli"
    exit 1
fi
echo "✓ Kiro CLI found"

if ! command -v uv &> /dev/null; then
    echo "❌ uv not found. Please install from: https://docs.astral.sh/uv/"
    exit 1
fi
echo "✓ uv found"

# Create directories
echo ""
echo "Creating Kiro directories..."
mkdir -p ~/.kiro/agents
mkdir -p ~/.kiro/prompts
echo "✓ Directories created"

# Install prompts
echo ""
echo "Installing agent prompts..."
cp prompts/aws-docs-agent.md ~/.kiro/prompts/
cp prompts/aws-docs-searcher.md ~/.kiro/prompts/
cp prompts/aws-docs-presenter.md ~/.kiro/prompts/
echo "✓ Prompts installed"

# Install agent configurations
echo ""
echo "Installing agent configurations..."
cp agents/aws-docs-agent.json ~/.kiro/agents/
cp agents/aws-docs-searcher.json ~/.kiro/agents/
cp agents/aws-docs-presenter.json ~/.kiro/agents/
echo "✓ Agent configs installed"

# Configure MCP server
echo ""
echo "Configuring MCP server..."
echo ""
echo "The AWS Documentation MCP server will be configured globally."
echo "It will be available to all agents that need it."
echo ""

# Check if mcp.json exists
if [ -f ~/.kiro/settings/mcp.json ]; then
    echo "⚠️  MCP configuration already exists at ~/.kiro/settings/mcp.json"
    echo ""
    read -p "Do you want to add/update the AWS Documentation MCP server? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping MCP configuration"
    else
        # Backup existing config
        cp ~/.kiro/settings/mcp.json ~/.kiro/settings/mcp.json.backup
        echo "✓ Backed up existing MCP config"
        
        # Add MCP server using Python
        python3 << 'EOF'
import json
import os

mcp_path = os.path.expanduser("~/.kiro/settings/mcp.json")
with open(mcp_path, 'r') as f:
    config = json.load(f)

# Add AWS Documentation MCP server if not present
if "awslabs.aws-documentation-mcp-server" not in config:
    config["awslabs.aws-documentation-mcp-server"] = {
        "command": "uvx",
        "args": ["awslabs.aws-documentation-mcp-server@latest"],
        "env": {}
    }
    
    with open(mcp_path, 'w') as f:
        json.dump(config, f, indent=2)
    print("✓ Added AWS Documentation MCP server")
else:
    print("✓ AWS Documentation MCP server already configured")
EOF
    fi
else
    # Create new mcp.json
    mkdir -p ~/.kiro/settings
    cat > ~/.kiro/settings/mcp.json << 'EOF'
{
  "awslabs.aws-documentation-mcp-server": {
    "command": "uvx",
    "args": ["awslabs.aws-documentation-mcp-server@latest"],
    "env": {}
  }
}
EOF
    echo "✓ Created MCP configuration"
fi

# Verify installation
echo ""
echo "Verifying installation..."
echo ""

agents_found=0
for agent in aws-docs-agent aws-docs-searcher aws-docs-presenter; do
    if kiro-cli agent list 2>&1 | grep -q "$agent"; then
        echo "✓ $agent registered"
        ((agents_found++))
    else
        echo "⚠️  $agent not found in agent list"
    fi
done

echo ""
if [ $agents_found -eq 3 ]; then
    echo "========================================="
    echo "✓ Installation Complete!"
    echo "========================================="
    echo ""
    echo "Usage:"
    echo "  kiro-cli chat --agent aws-docs-agent"
    echo ""
    echo "Example questions:"
    echo "  - How do I enable S3 versioning?"
    echo "  - What's the difference between Aurora Serverless v1 and v2?"
    echo "  - Does RDS support MySQL 8.0?"
    echo ""
else
    echo "========================================="
    echo "⚠️  Installation completed with warnings"
    echo "========================================="
    echo ""
    echo "Some agents were not registered. Try:"
    echo "  kiro-cli agent list | grep aws-docs"
    echo ""
fi
