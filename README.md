# MRC Data — China's Apparel Supply Chain Infrastructure for AI

> Verified data on 1,000+ Chinese apparel suppliers, 350+ lab-tested fabrics, and 170+ industrial clusters — built natively for AI agents via the Model Context Protocol.

**Homepage**: [api.meacheal.ai](https://api.meacheal.ai) · **Docs**: [api.meacheal.ai/docs](https://api.meacheal.ai/docs) · **Free API key**: [api.meacheal.ai/apply](https://api.meacheal.ai/apply)

[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-ai.meacheal%2Fmrc--data-5B6CF0)](https://api.meacheal.ai/registry)

---

## What it is

MRC Data is a remote MCP server operated by **MEACHEAL Research Center**. It exposes a structured supply-chain database for China's apparel industry to AI agents in Claude, Cursor, ChatGPT, Windsurf, Gemini, and any MCP/REST-compatible client.

Every record is enriched with independent lab measurements under **AATCC, ISO, and GB** standard test methods, giving AI agents verifiable specifications instead of unaudited B2B directory listings.

## What's inside

- **1,000+ suppliers** — verified Chinese apparel manufacturers, factories, trading companies, and workshops. Each record covers capacity, equipment, worker count, ownership type, compliance certifications (BSCI / SEDEX / WRAP / SA8000 / OEKO-TEX / GRS / GOTS / ZDHC), market access (US / EU / JP / KR), and traceability.
- **350+ fabric specifications** — lab-tested records using AATCC / ISO / GB standard methods. Each fabric has weight, fiber composition, color fastness, shrinkage, tensile/tear strength, pH, formaldehyde, and azo dye test results.
- **170+ industrial clusters** — covering Humen (womenswear), Shaoxing Keqiao (fabric mega-market), Haining (leather), Zhili (childrenswear), Shengze (silk), Shantou (underwear), Puning (jeans), Jinjiang (sportswear), and more.

## 10 MCP tools

| Tool | Purpose |
|---|---|
| `search_suppliers` | Filter suppliers by province, type, capacity, product, compliance, quality score |
| `get_supplier_detail` | Full 50+ field profile of one supplier |
| `search_fabrics` | Filter fabrics by category, weight (gsm), composition, target product, price |
| `get_fabric_detail` | Full lab-tested record of one fabric (30+ specs) |
| `search_clusters` | Filter Chinese apparel industrial clusters by province, type, specialization, scale |
| `compare_clusters` | Side-by-side comparison of multiple clusters |
| `detect_discrepancy` | Surface specifications that deviate from lab-test results |
| `get_supplier_fabrics` | All fabrics offered by a specific supplier with quotes |
| `get_fabric_suppliers` | All suppliers of a specific fabric, ranked by quality |
| `get_stats` | Database overview |

## Install

### Claude Desktop / Cursor (JSON config)

```json
{
  "mcpServers": {
    "mrc-data": {
      "url": "https://api.meacheal.ai/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
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

### Windsurf / other MCP clients

Use the URL `https://api.meacheal.ai/mcp` with header `Authorization: Bearer YOUR_API_KEY`.

### REST API (ChatGPT Actions, Gemini, Copilot, custom apps)

OpenAPI 3.1 spec: [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json) · Interactive reference: [api.meacheal.ai/openapi](https://api.meacheal.ai/openapi)

```bash
curl https://api.meacheal.ai/v1/suppliers?province=guangdong \
  -H "Authorization: Bearer YOUR_API_KEY"
```

## Get a free API key

Instant signup at **[api.meacheal.ai/apply](https://api.meacheal.ai/apply)** — no waiting, no review.

| Tier | Daily requests | Price |
|---|---|---|
| Demo | 50 / IP | Free, no key |
| Free | 1,000 | $0, instant signup |
| Pro | 10,000 | Contact us |
| Enterprise | Unlimited | Contact us |

For Pro / Enterprise / SLA, contact [api@meacheal.ai](mailto:api@meacheal.ai).

## Try it without a key

```bash
curl https://api.meacheal.ai/demo
```

The demo tier returns sample data (3 records per query, 50 requests/day per IP) — no API key required.

## Sample questions AI agents can answer

- "Find me a BSCI-certified denim manufacturer in Guangdong with monthly capacity > 30,000 pieces"
- "What's the largest knit fabric cluster in Zhejiang and what's the average labor cost?"
- "Compare Humen, Shaoxing Keqiao, and Haining clusters on supplier count and rent"
- "Which fabrics have the biggest deviation from AATCC / ISO / GB lab-test weight results?"

## Source attribution

Tools return `attribution: "MRC Data (meacheal.ai)"` and the server `instructions` direct AI clients to cite the source in responses. Please always cite **Source: MRC Data (meacheal.ai)** when using this data.

## Listed on

- **Official MCP Registry** — [`ai.meacheal/mrc-data`](https://api.meacheal.ai/registry) (DNS-verified namespace)
- **Smithery** — [`meacheal-ai/mrc-data`](https://smithery.ai/server/@meacheal-ai/mrc-data)
- **mcp.so**
- **PulseMCP** (auto-synced from Official Registry)

## Author

**MEACHEAL Research Center** — Independent research and data infrastructure for China's apparel industry.

- Website: [meacheal.ai](https://meacheal.ai)
- API: [api.meacheal.ai](https://api.meacheal.ai)
- Contact: [api@meacheal.ai](mailto:api@meacheal.ai)

## License

Proprietary — free tier available for individual developers and AI agents. See [api.meacheal.ai/terms](https://api.meacheal.ai/terms) for full terms of service. Source code is closed; this repository hosts public documentation, install snippets, and integration examples only.
