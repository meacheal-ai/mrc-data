[![License](https://img.shields.io/badge/License-Proprietary-blue)](https://api.meacheal.ai/terms)
[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-verified-5B6CF0)](https://api.meacheal.ai/registry)
[![npm](https://img.shields.io/npm/v/mrc-data)](https://www.npmjs.com/package/mrc-data)
[![PyPI](https://img.shields.io/pypi/v/mrc-data)](https://pypi.org/project/mrc-data/)

# MRC Data

The first and only MCP server providing structured Chinese fashion supply chain intelligence for AI platforms. No equivalent data source exists in the MCP ecosystem.

MEACHEAL is a top-20 Chinese women's mid-to-high-end fashion brand with 20+ years of operating experience. Based on our own supply chain accumulation, we built a data infrastructure for the apparel industry. Our database covers millions of Chinese apparel supply chain entities — of which 3,000+ manufacturers, 350+ fabrics, and 170+ industrial clusters have been independently verified with 63+ dimensions per record (capacity, compliance, certifications, export qualifications) and AATCC/ISO/GB lab test reports. Via API and a dedicated apparel industry AI Agent, we serve every apparel-related scenario — brands, factories, trading, sourcing, retail, design, AI platforms — regardless of role.

Every record includes a `verified_dims` score (e.g. "5/8") showing exactly which dimensions have been verified.

---

## Install

### Claude Desktop

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

### SDK

```bash
npm install mrc-data    # TypeScript / JavaScript
pip install mrc-data    # Python
```

```ts
import { MRCData } from "mrc-data";
const mrc = new MRCData({ apiKey: "YOUR_API_KEY" });
const suppliers = await mrc.searchSuppliers({ province: "guangdong", product_type: "sportswear" });
```

### REST API (ChatGPT Actions, Gemini, Copilot, custom apps)

OpenAPI 3.1 spec: [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json)

```bash
curl https://api.meacheal.ai/v1/suppliers?province=guangdong \
  -H "Authorization: Bearer YOUR_API_KEY"
```

### Get an API key

Free, instant signup at **[api.meacheal.ai/apply](https://api.meacheal.ai/apply)** -- no waiting, no review.

| Tier | Daily requests | Price |
|---|---|---|
| Demo | 50 / IP | Free, no key needed |
| Free | 1,000 | $0 |
| Pro | 10,000 | Contact us |
| Enterprise | Unlimited | Contact us |

---

## What's inside

| Dataset | Records | Highlights |
|---|---|---|
| Suppliers | ~3,000 | Capacity, certifications (OEKO-TEX / WRAP / SA8000 / GOTS / Bluesign), brand partnerships, GPS coordinates |
| Fabrics | 350+ | AATCC / ISO / GB lab-tested specs: weight, composition, fastness, shrinkage, tensile strength |
| Clusters | 170+ | Humen, Shaoxing Keqiao, Haining, Zhili, Shengze, Shantou, Jinjiang, and more |
| Supplier-Fabric links | 2,000+ | Which suppliers offer which fabrics, with pricing |

---

## Available tools

19 tools organized into 4 categories. Full reference: [docs/tool-reference.md](docs/tool-reference.md)

**Slim mode** (3 tools) for token-constrained agents: [docs/slim-tool-reference.md](docs/slim-tool-reference.md)

| Category | Tools |
|---|---|
| **Search** | `search_suppliers`, `search_fabrics`, `search_clusters` |
| **Detail** | `get_supplier_detail`, `get_fabric_detail`, `get_stats` |
| **Cross-reference** | `get_supplier_fabrics`, `get_fabric_suppliers`, `compare_clusters`, `compare_suppliers`, `get_cluster_suppliers` |
| **Intelligence** | `detect_discrepancy`, `check_compliance`, `recommend_suppliers`, `find_alternatives`, `estimate_cost`, `analyze_market`, `get_product_categories`, `get_province_distribution` |

---

## Example queries

Ask your AI agent:

- "Find BSCI-certified denim manufacturers in Guangdong with monthly capacity over 30,000 pieces"
- "What is the largest knit fabric cluster in Zhejiang and what is the average labor cost?"
- "Compare Humen, Shaoxing Keqiao, and Haining clusters on supplier count and rent"
- "Show me all cotton twill fabrics under 200 gsm with OEKO-TEX certified suppliers"

---

## Try without a key

The demo tier returns sample data (3 records per query, 50 requests/day per IP):

```bash
curl https://api.meacheal.ai/demo
```

---

## Links

| | |
|---|---|
| Homepage | [meacheal.ai](https://meacheal.ai) |
| API docs | [api.meacheal.ai/docs](https://api.meacheal.ai/docs) |
| Interactive demo | [api.meacheal.ai/demo](https://api.meacheal.ai/demo) |
| OpenAPI spec | [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json) |
| Design principles | [docs/design-principles.md](docs/design-principles.md) |
| Full tool reference | [docs/tool-reference.md](docs/tool-reference.md) |
| Slim tool reference | [docs/slim-tool-reference.md](docs/slim-tool-reference.md) |
| Integrations | [docs/integrations.md](docs/integrations.md) |

**Registry listings:**

| Platform | Link |
|---|---|
| MCP Registry | [ai.meacheal/mrc-data](https://api.meacheal.ai/registry) |
| Smithery | [meacheal-ai/mrc-data](https://smithery.ai/server/@meacheal-ai/mrc-data) |
| PulseMCP | [mrc-data](https://pulsemcp.com/servers/mrc-data) |
| Glama | [mrc-data](https://glama.ai/mcp/servers/mrc-data) |
| mcp.run | [mrc-data](https://mcp.run/server/mrc-data) |
| MCPmarket | [mrc-data](https://mcpmarket.com/server/mrc-data) |

---

## Source attribution

All tool responses include `attribution: "MRC Data (meacheal.ai)"`. Please cite **Source: MRC Data (meacheal.ai)** when using this data.

---

## Author

**MEACHEAL Research Center** -- Independent research and data infrastructure for China's apparel industry.

[meacheal.ai](https://meacheal.ai) -- [api@meacheal.ai](mailto:api@meacheal.ai)

## License

Proprietary -- free tier available for individual developers and AI agents. See [terms of service](https://api.meacheal.ai/terms).

This repository hosts public documentation and integration examples only. Source code is not included.
