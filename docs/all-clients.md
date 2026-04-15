# MRC Data -- All Client Configurations

Setup guides for every MCP-compatible client. Get a free API key at [api.meacheal.ai/apply](https://api.meacheal.ai/apply).

**Universal config** -- most clients accept this JSON format:

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

If your client isn't listed below, try pasting the above into your client's MCP config file.

---

## IDEs & Code Editors

### Claude Desktop (remote HTTP)

Add to `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Claude Desktop (stdio / npx)

```json
{
  "mcpServers": {
    "mrc-data": {
      "command": "npx",
      "args": ["-y", "mrc-data"],
      "env": { "MRC_API_KEY": "YOUR_API_KEY" }
    }
  }
}
```

### Claude Code

```bash
claude mcp add --scope user --transport http mrc-data \
  https://api.meacheal.ai/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
```

### Cursor

Add to `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### VS Code (Copilot)

Add to `.vscode/mcp.json`:

```json
{
  "servers": {
    "mrc-data": {
      "type": "http",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### JetBrains (IntelliJ / PyCharm / WebStorm)

Add to `.junie/mcp/mcp.json` (project-level):

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Windsurf

Add to `~/.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "mrc-data": {
      "serverUrl": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Cline

Add to Cline MCP settings:

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Roo Code

Add to `.roo/mcp.json` (project) or `~/.vscode/globalMcp.json` (global):

```json
{
  "mcpServers": {
    "mrc-data": {
      "type": "streamable-http",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Continue.dev

Add to `~/.continue/config.yaml`:

```yaml
mcpServers:
  - name: mrc-data
    type: streamable-http
    url: https://api.meacheal.ai/mcp
    requestOptions:
      headers:
        Authorization: Bearer YOUR_API_KEY
```

### Zed

Add to Zed settings (`settings.json`):

```json
{
  "context_servers": {
    "mrc-data": {
      "settings": {
        "url": "https://api.meacheal.ai/mcp",
        "headers": { "Authorization": "Bearer YOUR_API_KEY" }
      }
    }
  }
}
```

### Sourcegraph Cody

Add to VS Code `settings.json`:

```json
{
  "cody.mcpServers": {
    "mrc-data": {
      "type": "streamable-http",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

---

## Agent Frameworks

### Hermes Agent (Nous Research)

Add to `~/.hermes/config.yaml`:

```yaml
mcp_servers:
  mrc-data:
    url: "https://api.meacheal.ai/mcp"
    headers:
      Authorization: "Bearer YOUR_API_KEY"
```

Or via CLI:

```bash
hermes mcp add mrc-data --url "https://api.meacheal.ai/mcp"
```

### n8n

Add an **MCP Client Tool** node to your AI Agent workflow:
- Create credentials: HTTP Stream URL = `https://api.meacheal.ai/mcp`
- Authentication: Bearer, token = `YOUR_API_KEY`

### Dify

Install `dify-plugin-tools-mcp_sse` from Marketplace, then configure:

```json
{
  "mcpServers": {
    "mrc-data": {
      "transport": "streamable_http",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" },
      "timeout": 60
    }
  }
}
```

### LibreChat

Add to `librechat.yaml`:

```yaml
mcpServers:
  mrc-data:
    type: streamable-http
    url: https://api.meacheal.ai/mcp
    headers:
      Authorization: "Bearer YOUR_API_KEY"
```

---

## Desktop Apps

### Raycast AI

Open Manage MCP Servers > Show Config File, add:

```json
{
  "mcpServers": {
    "mrc-data": {
      "type": "streamable-http",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

### Warp Terminal

Settings > MCP Servers > + Add:

```json
{
  "mrc-data": {
    "url": "https://api.meacheal.ai/mcp",
    "headers": { "Authorization": "Bearer YOUR_API_KEY" }
  }
}
```

### Cherry Studio

Settings > MCP Servers > Add Server:
- Type: Streamable HTTP
- URL: `https://api.meacheal.ai/mcp`
- Header: `Authorization=Bearer YOUR_API_KEY`

### Open WebUI

Admin Settings > External Tools > + Add Server:
- Type: MCP (Streamable HTTP)
- URL: `https://api.meacheal.ai/mcp`
- Auth: Bearer token = `YOUR_API_KEY`

### AnythingLLM

Add to MCP config (`anythingllm_mcp_servers.json`):

```json
{
  "mcpServers": {
    "mrc-data": {
      "type": "streamable",
      "url": "https://api.meacheal.ai/mcp",
      "headers": { "Authorization": "Bearer YOUR_API_KEY" }
    }
  }
}
```

---

## SDK & REST API

### TypeScript / JavaScript

```bash
npm install mrc-data
```

```ts
import { MRCData } from "mrc-data";
const mrc = new MRCData({ apiKey: "YOUR_API_KEY" });
const suppliers = await mrc.searchSuppliers({ province: "guangdong", product_type: "sportswear" });
```

### Python

```bash
pip install mrc-data
```

```python
from mrc_data import MRCData
mrc = MRCData(api_key="YOUR_API_KEY")
suppliers = mrc.search_suppliers(province="guangdong", product_type="sportswear")
```

### REST API (ChatGPT Actions, Gemini, Copilot, any HTTP client)

OpenAPI 3.1 spec: [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json)

```bash
curl https://api.meacheal.ai/v1/suppliers?province=guangdong \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

## Quick Start (npx)

No install needed:

```bash
MRC_API_KEY=your_key npx mrc-data
```

---

**Don't see your client?** Most MCP-compatible tools accept the universal JSON config at the top of this page. Check your client's MCP documentation for the config file location.

**Get a free API key:** [api.meacheal.ai/apply](https://api.meacheal.ai/apply) -- instant, no waiting.
