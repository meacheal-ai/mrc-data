# MRC Data -- Integration Guide

How to connect MRC Data to agent orchestration frameworks and memory systems.

---

## Agent Frameworks

### ByteDance Deer Flow

Deer Flow natively supports remote HTTP MCP servers.

Add to `extensions_config.json`:

```json
{
  "mcpServers": {
    "meacheal": {
      "enabled": true,
      "type": "http",
      "url": "https://api.meacheal.ai/mcp",
      "description": "MRC Data - Chinese apparel supply chain intelligence"
    }
  }
}
```

Docs: `backend/docs/MCP_SERVER.md` in the [deer-flow repo](https://github.com/bytedance/deer-flow).

---

### Microsoft Agent Framework

Supports both declarative YAML and programmatic approaches.

**YAML (Python declarative):**

```yaml
tools:
  - kind: mcp
    name: meacheal-mcp
    description: MRC Data - Chinese apparel supply chain
    url: https://api.meacheal.ai/mcp
    approvalMode: never
```

**C# code:**

```csharp
await using var mcpClient = await McpClient.CreateAsync(
    new HttpClientTransport(new() {
        Endpoint = new Uri("https://api.meacheal.ai/mcp"),
        Name = "MEACHEAL MCP"
    }));
var tools = await mcpClient.ListToolsAsync();
```

**Python code:**

```python
from agent_framework import McpClient
client = McpClient(url="https://api.meacheal.ai/mcp")
tools = await client.list_tools()
```

Docs: `python/samples/02-agents/mcp/` in the [agent-framework repo](https://github.com/microsoft/agent-framework).

---

## Agent Memory Systems

### supermemory (Recommended)

Cloud-hosted memory service. Works as a sibling MCP server -- the agent stores and recalls context across sessions automatically.

**Setup:** Register both MRC Data and supermemory as MCP servers:

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_MRC_KEY" }
    },
    "supermemory": {
      "url": "https://mcp.supermemory.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_SM_KEY" }
    }
  }
}
```

**How it works:**

1. Agent calls `search_suppliers(province='guangdong', product_type='sportswear')` from MRC Data
2. Agent stores relevant findings via supermemory's `memory` tool
3. Next session, agent calls `recall` to retrieve past sourcing preferences
4. Result: "This user sources cotton knits from Shaoxing cluster" persists across conversations

No custom code needed. The agent decides what to remember.

Get a key at [supermemory.com](https://supermemory.com).

---

### OpenViking (Advanced)

Self-hosted context database from ByteDance. Filesystem paradigm for organizing agent context. More powerful for complex multi-session workflows, but heavier setup.

**Architecture:**
- L0/L1/L2 tiered context loading (saves tokens)
- Directory-based organization (suppliers by cluster, fabrics by category)
- Automatic session memory extraction
- Requires VLM + embedding model

**Setup:**

```bash
pip install openviking --upgrade
```

Configure `~/.openviking/ov.conf` with your model provider (supports OpenAI, Anthropic via LiteLLM, Volcengine).

**Integration pattern:** Export supplier data as structured documents into OpenViking's filesystem, then agents query OpenViking for context before calling MRC Data MCP tools.

Docs: [OpenViking repo](https://github.com/volcengine/OpenViking).

---

## Quick Comparison

| Feature | supermemory | OpenViking |
|---|---|---|
| Hosting | Cloud (managed) | Self-hosted |
| Setup effort | 5 minutes | 1-2 hours |
| MCP native | Yes (sibling server) | No (separate system) |
| Structured data | Text/embeddings only | Filesystem paradigm |
| Best for | Simple memory across sessions | Complex multi-agent workflows |
| Cost | SaaS pricing | Free (self-host) + model costs |
