# AWS Documentation Agent

**A multi-agent AI system that answers AWS questions with precise documentation citations.**

## What It Does

Transforms AWS questions into accurate answers with exact quotes from official AWS documentation through a 2-agent pipeline:

1. **Searcher** - Finds relevant AWS documentation pages using MCP and web search
2. **Presenter** - Extracts exact quotes and formats with `[AWS-DOC]` citations

## Key Features

✅ **Citation-Based**: Every answer includes `[AWS-DOC]` tags with source URLs  
✅ **Exact Quotes**: Fetches actual text from documentation, not summaries  
✅ **Fast Discovery**: MCP-powered search across AWS docs  
✅ **Verifiable**: All claims traceable to official sources  
✅ **Zero Hallucination**: Only uses official AWS documentation

## Prerequisites

- [Kiro CLI](https://github.com/aws/kiro-cli) installed
- `uv` package manager installed (for MCP servers)

## Installation

```bash
# 1. Clone or download this repository
cd aws-docs-agent-public

# 2. Run the installation script
chmod +x install.sh
./install.sh
```

The installer will:
- Copy agent configurations to `~/.kiro/agents/`
- Copy prompts to `~/.kiro/prompts/`
- Configure AWS Documentation MCP server
- Verify installation

## Usage

```bash
kiro-cli chat --agent aws-docs-agent
```

**Example questions:**
- "How do I enable S3 versioning?"
- "What's the difference between Aurora Serverless v1 and v2?"
- "Does RDS support MySQL 8.0?"

**System delivers:**
- Direct answer with exact AWS documentation quotes
- `[AWS-DOC: https://docs.aws.amazon.com/...]` citations
- Multiple sources when relevant
- Clear indication of what's not documented

## Architecture

```
User Question
     ↓
aws-docs-agent (orchestrator)
     ↓
aws-docs-searcher → /tmp/aws-docs-search-results.md
     ↓
aws-docs-presenter → Formatted response with citations
     ↓
User receives answer
```

**File-based communication** between agents for speed and reliability.

## Configuration

Agent configurations are in `~/.kiro/agents/`:
- `aws-docs-agent.json` - Orchestrator
- `aws-docs-searcher.json` - Search agent with MCP server
- `aws-docs-presenter.json` - Formatting agent

Prompts are in `~/.kiro/prompts/`:
- `aws-docs-agent.md`
- `aws-docs-searcher.md`
- `aws-docs-presenter.md`

## Troubleshooting

**Agent not found:**
```bash
kiro-cli agent list | grep aws-docs
```

**MCP server issues:**
```bash
# Test MCP server manually
uvx awslabs.aws-documentation-mcp-server@latest
```

**Check logs:**
```bash
# Kiro CLI logs location
~/.kiro/logs/
```

## Uninstall

```bash
# Remove agents
rm ~/.kiro/agents/aws-docs-*.json

# Remove prompts
rm ~/.kiro/prompts/aws-docs-*.md
```

## Technical Details

- **MCP Server**: `awslabs.aws-documentation-mcp-server@latest`
- **Communication**: File-based (`/tmp/aws-docs-search-results.md`)
- **Tools**: search_documentation, read_documentation, web_search, web_fetch
- **Framework**: Kiro CLI multi-agent system

## License

MIT License - See LICENSE file for details


## Author

Created by [frankbpr]

Built with AWS MCP servers and Kiro CLI multi-agent framework.
