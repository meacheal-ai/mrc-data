[![License](https://img.shields.io/badge/License-Proprietary-blue)](https://api.meacheal.ai/terms)
[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-verified-5B6CF0)](https://api.meacheal.ai/registry)
[![npm](https://img.shields.io/npm/v/mrc-data)](https://www.npmjs.com/package/mrc-data)
[![PyPI](https://img.shields.io/pypi/v/mrc-data)](https://pypi.org/project/mrc-data/)

# MRC Data

China's apparel supply chain data infrastructure for AI agents.

---

## Quick start

### Claude Desktop / Cursor

Add to your MCP config (`claude_desktop_config.json` or `.cursor/mcp.json`):

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

### Claude Code CLI

```bash
claude mcp add --scope user --transport http mrc-data \
  https://api.meacheal.ai/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
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
| Suppliers | 1,040 | Capacity, equipment, certifications (BSCI / OEKO-TEX / GRS / GOTS), market access |
| Fabrics | 351 | AATCC / ISO / GB lab-tested specs: weight, composition, fastness, shrinkage, tensile strength |
| Clusters | 173 | Humen, Shaoxing Keqiao, Haining, Zhili, Shengze, Shantou, Jinjiang, and more |
| Supplier-Fabric links | 2,467 | Which suppliers offer which fabrics, with pricing |

---

## Available tools (10)

| Tool | What it does |
|---|---|
| `search_suppliers` | Filter by province, type, capacity, product, compliance, quality score |
| `get_supplier_detail` | Full 50+ field profile of one supplier |
| `search_fabrics` | Filter by category, weight (gsm), composition, target product, price |
| `get_fabric_detail` | Full lab-tested record with 30+ specifications |
| `search_clusters` | Filter industrial clusters by province, type, specialization, scale |
| `compare_clusters` | Side-by-side comparison of multiple clusters |
| `detect_discrepancy` | Surface specs that deviate from AATCC / ISO / GB lab-test results |
| `get_supplier_fabrics` | All fabrics offered by a specific supplier, with quotes |
| `get_fabric_suppliers` | All suppliers of a specific fabric, ranked by quality |
| `get_stats` | Database overview and summary statistics |

---

## Example queries

Ask your AI agent:

- "Find BSCI-certified denim manufacturers in Guangdong with monthly capacity over 30,000 pieces"
- "What is the largest knit fabric cluster in Zhejiang and what is the average labor cost?"
- "Compare Humen, Shaoxing Keqiao, and Haining clusters on supplier count and rent"
- "Show me all cotton twill fabrics under 200 gsm with OEKO-TEX certified suppliers"
- "Which fabrics have the biggest deviation from AATCC / ISO / GB lab-test weight results?"

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
| Homepage | [api.meacheal.ai](https://api.meacheal.ai) |
| Docs | [api.meacheal.ai/docs](https://api.meacheal.ai/docs) |
| Interactive demo | [api.meacheal.ai/demo](https://api.meacheal.ai/demo) |
| OpenAPI spec | [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json) |
| OpenAPI reference | [api.meacheal.ai/openapi](https://api.meacheal.ai/openapi) |
| MCP Registry | [ai.meacheal/mrc-data](https://api.meacheal.ai/registry) |
| Smithery | [meacheal-ai/mrc-data](https://smithery.ai/server/@meacheal-ai/mrc-data) |

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
