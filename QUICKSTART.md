# Quick Start Guide

## Installation (2 minutes)

```bash
# 1. Download the repository
git clone [your-repo-url]
cd aws-docs-agent-public

# 2. Run installer
chmod +x install.sh
./install.sh
```

## First Use (30 seconds)

```bash
kiro-cli chat --agent aws-docs-agent
```

Then ask any AWS question:
```
How do I enable S3 versioning?
```

## What You'll Get

✅ Direct answer with exact AWS documentation quotes  
✅ `[AWS-DOC]` tags for every citation  
✅ Clickable links to official sources  
✅ Clear indication of what's not documented

## Example Output

```markdown
## S3 Bucket Versioning

### Answer
S3 versioning can be enabled through the AWS Console, CLI, or SDK...

### What AWS Documentation Says
[AWS-DOC] "Versioning is a means of keeping multiple variants..."
**Source:** [Using versioning](https://docs.aws.amazon.com/...)

### ⚠️ Important Limitations
All key information is documented above.
```

## Troubleshooting

**Agent not found?**
```bash
kiro-cli agent list | grep aws-docs
```

**MCP server issues?**
```bash
uvx awslabs.aws-documentation-mcp-server@latest
```

## More Examples

See [EXAMPLES.md](EXAMPLES.md) for detailed usage examples.

## Architecture

```
User Question
     ↓
aws-docs-agent (orchestrator)
     ↓
aws-docs-searcher (finds docs)
     ↓
aws-docs-presenter (formats with citations)
     ↓
User receives answer
```

## Support

- Issues: [your-repo-url]/issues
- Documentation: See README.md
- Examples: See EXAMPLES.md
