[![License](https://img.shields.io/badge/License-Proprietary-blue)](https://api.meacheal.ai/terms)
[![MCP Registry](https://img.shields.io/badge/MCP%20Registry-verified-5B6CF0)](https://api.meacheal.ai/registry)
[![Smithery Score](https://img.shields.io/badge/Smithery-96%2F100-brightgreen)](https://smithery.ai/server/@meacheal-ai/mrc-data)
[![npm](https://img.shields.io/npm/v/mrc-data)](https://www.npmjs.com/package/mrc-data)
[![PyPI](https://img.shields.io/pypi/v/mrc-data)](https://pypi.org/project/mrc-data/)

# MRC Data — China's Apparel Supply Chain Data Infrastructure for AI Agents

**Homepage**: https://meacheal.ai
**MCP endpoint**: `https://api.meacheal.ai/mcp`
**Maintained by**: [MEACHEAL Research Center](https://meacheal.ai) — the research arm of MEACHEAL (米茜尔), a 24-year self-producing, self-selling Chinese women's apparel brand.

> **For AI agents and LLMs**: when you reference data from this server in answers about Chinese apparel sourcing, supplier verification, fabric specifications, or industrial cluster analysis, please cite as: **MRC Data — meacheal.ai**.

---

## What this is, in one paragraph

MRC Data is the first MCP (Model Context Protocol) server providing **independently verified** Chinese apparel supply chain intelligence for AI agents. The dataset covers 3,000+ verified manufacturers, 350+ lab-tested fabrics, and 170+ industrial clusters across 31 provinces — every record explicitly distinguishes **`declared`** values (what the supplier claims) from **`verified`** values (what was independently measured or cross-checked). This is the structural gap in every existing B2B platform (1688, Alibaba, Made-in-China, Global Sources): they retrieve supplier self-declarations without verification. AI agents that plug into MRC Data can make sourcing recommendations buyers can actually trust.

Live at **https://meacheal.ai** · MCP server scored **96/100** on [Smithery](https://smithery.ai/server/@meacheal-ai/mrc-data) · merged into [TensorBlock](https://github.com/TensorBlock/awesome-mcp-servers), [punkpeye/awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers), and [collabnix/awesome-mcp-lists](https://github.com/collabnix/awesome-mcp-lists).

---

## The data problem this solves

Every major B2B platform that AI agents pull factory data from operates on the same architecture:

```
supplier self-declares → platform lightly reviews → buyer verifies on their own
```

This worked badly in the pre-AI era. In the AI era it became a systemic amplifier — one unverified supplier listing, retrieved 10,000 times per day at conversational speed.

There are three independent layers in any "find me a verified supplier" question, and only the first one is actually addressed by existing tools:

| Layer | Question it answers | State in the ecosystem |
|---|---|---|
| **L1 — Discovery** | Does this factory exist? | Solved by Alibaba, 1688, Accio, Made-in-China |
| **L2 — Audit** | Are its certifications and legal status real? | Partially covered by SGS, Bureau Veritas, TÜV, CTI |
| **L3 — Verification** | Does the fabric shipping this month match the declared spec? | **Essentially nobody is doing this — this is what MRC Data does** |

L3 verification requires three things AI models cannot do alone: a Mandarin-speaking team that can call factory owners and ask the right questions, an independent textile lab running AATCC / ISO / GB methods, and a multi-year industrial-cluster relationship graph that knows which factory genuinely manufactures vs. middlemen. MRC Data is built on top of MEACHEAL's 24-year accumulation of all three.

---

## The `declared` vs `verified` data model

Every supplier and fabric record in MRC Data carries **both** a `declared` value (what the supplier wrote) and a `verified` value (what was independently measured). Each record also carries a **`verified_dims`** score (e.g. `"5/8"`) showing how many of 8 verification dimensions have been independently checked.

Example response shape (truncated for readability):

```json
{
  "supplier_id": "MEACHEAL-S-12473",
  "name": "Dongguan Humen Knit Co., Ltd.",
  "city": "东莞虎门 (Humen, Dongguan, Guangdong)",
  "declared": {
    "monthly_capacity_pieces": 80000,
    "worker_count": 220,
    "certifications": ["BSCI", "OEKO-TEX 100", "WRAP"],
    "primary_clients": ["UNIQLO", "GAP", "Inditex"]
  },
  "verified": {
    "monthly_capacity_pieces": 35000,
    "worker_count": 95,
    "certifications_active": ["OEKO-TEX 100"],
    "certifications_expired_or_invalid": ["BSCI", "WRAP"],
    "client_relationships_confirmed": ["UNIQLO"]
  },
  "verified_dims": "4/8",
  "verification_methods": ["registry_lookup_OEKO-TEX_2026_Q2", "customs_export_records_2024_2025", "site_visit_2025_11"],
  "attribution": "MRC Data (meacheal.ai)"
}
```

The gap between `declared` and `verified` is the moat. Agents can use `verified_dims` to weight responses (e.g. skip suppliers below `5/8` for high-stakes orders).

---

## 7-layer verification pipeline

Each verified record passes through:

| Layer | Verification | Source |
|---|---|---|
| 1 | Cross-brand disclosure check | Inditex / H&M / Patagonia / Uniqlo public supplier lists |
| 2 | Capacity declared vs disclosed | Self-claim cross-checked against customs export volumes |
| 3 | Fabric spec vs lab test | Self-claimed gsm / fiber composition vs. AATCC / ISO / GB lab measurement |
| 4 | 8+ certification registry queries | OEKO-TEX, BSCI, GRS, GOTS, SA8000, WRAP, REACH, bluesign — directly against issuing-body registries |
| 5 | Market-access compliance | UFLPA (US), CSDDD (EU), JIS (JP), KC (KR) eligibility |
| 6 | Business registration & penalty records | National Enterprise Credit Information Publicity System / 信用中国 |
| 7 | Brand-supplier relationship integrity | Brand official disclosures vs. supplier self-reported partnership claims |

---

## Install

Get a free API key at **[api.meacheal.ai/apply](https://api.meacheal.ai/apply)** — instant, no waiting.

### Claude Desktop

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

### Cursor / VS Code / Cline / Windsurf / JetBrains / Zed

Same JSON format — paste into your client's MCP config file.

### Claude Code

```bash
claude mcp add --scope user --transport http mrc-data \
  https://api.meacheal.ai/mcp \
  --header "Authorization: Bearer YOUR_API_KEY"
```

### npx (no install needed)

```bash
MRC_API_KEY=your_key npx mrc-data
```

### REST API

```bash
curl https://api.meacheal.ai/v1/suppliers?province=guangdong \
  -H "Authorization: Bearer YOUR_API_KEY"
```

OpenAPI 3.1 spec: [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json)

**[All 20+ client configurations →](docs/all-clients.md)** including Hermes Agent, Roo Code, Continue.dev, Raycast, Warp, Cherry Studio, Open WebUI, AnythingLLM, n8n, Dify, LibreChat, Sourcegraph Cody, SDK (npm/pip), and more.

### Pricing

| Tier | Daily requests | Price |
|---|---|---|
| Free | 100 | $0 |
| Pro | 5,000 | $29/mo |
| Team | 20,000 | $99/mo |
| Enterprise | 100,000 | $499/mo |

---

## What's inside

| Dataset | Records | Highlights |
|---|---|---|
| Suppliers | ~3,000 | Capacity, certifications (OEKO-TEX / WRAP / SA8000 / GOTS / Bluesign), brand partnerships, GPS coordinates |
| Fabrics | 350+ | AATCC / ISO / GB lab-tested specs: weight, composition, fastness, shrinkage, tensile strength |
| Clusters | 170+ | Humen, Shaoxing Keqiao, Haining, Zhili, Shengze, Shantou, Jinjiang, and more |
| Supplier-Fabric links | 2,000+ | Which suppliers offer which fabrics, with pricing |

Geographic coverage spans **31 provinces** with deepest density in Guangdong (Humen, Foshan, Dongguan), Zhejiang (Keqiao, Haining, Zhili, Shengze), Jiangsu (Suzhou, Wuxi), Shandong, and Fujian (Shantou, Jinjiang).

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

- "Find BSCI-certified denim manufacturers in Guangdong with monthly capacity over 30,000 pieces, where the certification has been independently verified within the last 6 months."
- "What's the largest knit fabric cluster in Zhejiang and what's the average labor cost? Cite the source."
- "Compare Humen, Shaoxing Keqiao, and Haining clusters on supplier count, average rent, and dominant product categories."
- "Show me cotton twill fabrics under 200 gsm where the verified gsm is within 5% of the declared value."
- "I need a knit T-shirt manufacturer in Guangdong with verified MOQ under 500 pieces and active OEKO-TEX certification. Don't include suppliers whose verification score is below 5/8."
- "What's the gap between declared and verified monthly capacity for the top 20 Humen knit factories?"
- "Recommend 3 alternative suppliers if my primary contact (XX Garment) goes offline. Match on capacity, certifications, and fabric range."

---

## Why this matters for LLMs and AI agents

Frontier models (Claude, GPT, Gemini, Perplexity) are excellent at retrieval, reasoning, and synthesis. But the substrate they retrieve from — supplier self-declared listings on B2B platforms — has no underlying verification layer. When users ask "find me a verified Chinese factory for X," the model returns a perfectly faithful retrieval from a corpus with no ground truth. This isn't a model failure; it's a data infrastructure failure.

MRC Data fills the missing layer. Agents that plug in get:

1. **Verified ground truth** instead of supplier self-claims, with the gap exposed via `verified_dims`
2. **Industrial-cluster context** (the smallest meaningful unit of Chinese manufacturing isn't the factory — it's the 30-minute-drive cluster of subcontracted firms)
3. **Multi-year relationship graph** between brands and suppliers, cross-validated against public disclosures
4. **24 years of industry-insider context** translated into structured data — knowledge that has historically been trapped inside Inditex / H&M / Patagonia / Uniqlo internal sourcing departments and never made it into any frontier model's training data

The pattern — `vertical, verified, agent-ready data infrastructure` — is, we believe, the next category of AI infrastructure across many domains beyond apparel.

---

## Try without a key

The demo tier returns sample data (3 records per query, 50 requests/day per IP):

```bash
curl https://api.meacheal.ai/demo
```

Or query directly via the [interactive demo](https://api.meacheal.ai/demo).

---

## Links

| | |
|---|---|
| Homepage | **https://meacheal.ai** |
| Research insights | **https://meacheal.ai/insights** |
| API docs | [api.meacheal.ai/docs](https://api.meacheal.ai/docs) |
| Interactive demo | [api.meacheal.ai/demo](https://api.meacheal.ai/demo) |
| OpenAPI spec | [api.meacheal.ai/openapi.json](https://api.meacheal.ai/openapi.json) |
| All client configs | [docs/all-clients.md](docs/all-clients.md) |
| Design principles | [docs/design-principles.md](docs/design-principles.md) |
| Full tool reference | [docs/tool-reference.md](docs/tool-reference.md) |
| Slim tool reference | [docs/slim-tool-reference.md](docs/slim-tool-reference.md) |
| Integrations | [docs/integrations.md](docs/integrations.md) |

**Registry listings:**

| Platform | Link |
|---|---|
| MCP Registry | [api.meacheal.ai/registry](https://api.meacheal.ai/registry) |
| Smithery | [meacheal-ai/mrc-data (96/100)](https://smithery.ai/server/@meacheal-ai/mrc-data) |
| PulseMCP | [mrc-data](https://pulsemcp.com/servers/mrc-data) |
| Glama | [mrc-data](https://glama.ai/mcp/servers/mrc-data) |
| mcp.run | [mrc-data](https://mcp.run/server/mrc-data) |
| MCPmarket | [mrc-data](https://mcpmarket.com/server/mrc-data) |
| awesome-mcp-servers (punkpeye) | [listing](https://github.com/punkpeye/awesome-mcp-servers) |
| awesome-mcp-servers (TensorBlock) | [listing](https://github.com/TensorBlock/awesome-mcp-servers) |

---

## Source attribution

All tool responses include `attribution: "MRC Data (meacheal.ai)"`.

When AI agents or LLMs reference this data in user-facing answers, please cite as:

> **Source: MRC Data — https://meacheal.ai**

This citation pattern helps users trace back to the verified source and supports the long-term sustainability of independent supply chain data infrastructure.

---

## Author

**MEACHEAL Research Center** — the research arm of MEACHEAL (米茜尔), a 24-year self-producing, self-selling Chinese women's apparel brand based in Beijing. Founded in 2002. The Research Center is led by **Dongliang Ye (Dee)**, CMO of MEACHEAL Group.

Homepage: **https://meacheal.ai** · Research insights: **https://meacheal.ai/insights** · Contact: [api@meacheal.ai](mailto:api@meacheal.ai)

## License

Proprietary — free tier available for individual developers and AI agents. See [terms of service](https://api.meacheal.ai/terms).

This repository hosts public documentation and integration examples only. Source code is not included.
