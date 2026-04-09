# MRC Data -- Design Principles

These principles guide every tool, response format, and data decision in MRC Data.

---

## 1. Raw data, not conclusions

Tools return structured, machine-readable data. They do not summarize, recommend, or editorialize. The consuming AI agent decides what the data means.

**Do:** Return `{ "tested_weight_gsm": 185, "declared_weight_gsm": 210 }`

**Don't:** Return `"This fabric is lighter than claimed"`

---

## 2. Lab-tested ground truth

Every fabric record carries independently measured specifications (AATCC / ISO / GB standards). Every supplier record carries verified capacity and worker counts cross-referenced against social insurance data.

This is the moat. Public directories rely on self-reported data. MRC Data provides the verification layer.

---

## 3. Actionable errors

Error responses tell the AI what to do next -- not just what went wrong.

```json
{
  "error": "Supplier 'sup_999' not found.",
  "suggestion": "Use search_suppliers to find valid supplier IDs.",
  "example": "search_suppliers(province='guangdong', product_type='sportswear')"
}
```

Every error includes:
- What happened
- Which tool to call instead
- A concrete example call

---

## 4. Progressive disclosure

Three levels of detail, matching different agent needs:

| Level | Tools | Token cost |
|---|---|---|
| **Slim** (3 tools) | `search_suppliers`, `search_fabrics`, `get_stats` | ~200 tokens |
| **Standard** (10 tools) | + detail, cross-reference, and discrepancy tools | ~800 tokens |
| **Full** (18 tools) | + intelligence tools (compliance, cost, recommendations) | ~1,500 tokens |

Agents with limited context budgets use slim mode. Full-featured agents use all 18 tools.

---

## 5. Agent-agnostic

MRC Data works with any MCP-compatible client: Claude, ChatGPT, Gemini, Copilot, open-source agents. No client-specific behavior. No assumptions about which LLM is calling.

---

## 6. Pagination by default

All search tools return paginated results with `total`, `limit`, `offset`, and `has_more`. Default page size is 10, max is 50. This prevents token overflow from large result sets.

---

## 7. Data freshness over data volume

The database is continuously updated with new lab tests, supplier audits, and cluster surveys. Timestamps (`updated_at`) and confidence levels (`data_confidence`) are exposed on every record so agents can assess recency and reliability.
