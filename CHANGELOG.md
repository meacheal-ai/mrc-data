# Changelog

All notable changes to MRC Data are documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [2.2.4] - 2026-04-18

### Added
- MCP Resources expanded to **6** (from 3): `database-overview`, `compliance-standards`, `province-map`, `tool-selection-guide`, `synonyms`, `fabric-test-methods`
- MCP Prompts expanded to **13** (from 3): `find-supplier`, `find-fabric`, `compare-clusters`, `sourcing-checklist`, `cost-estimation-flow`, `compliance-audit-walkthrough`, `supplier-due-diligence`, `fabric-selection-guide`, `cluster-comparison-report`, `alternative-sourcing-strategy`, `market-entry-china-sourcing`, `quality-verification-protocol`, `budget-tier-matching`
- Tool descriptions enriched with USE WHEN / WORKFLOW / RETURNS / EXAMPLES / AVOID sections across all 19 tools

### Documentation
- Trust bar added to `/apply` and `/docs` landing pages (Smithery score + tool count + record scale)

## [2.2.3] - 2026-04-15

### Added
- stdio proxy wrapper (index.js) for Official MCP Registry compatibility
- Published to npm as `mrc-data@2.2.3`
- MIT license for npm package (data/API remain proprietary)

## [2.2.2] - 2026-04-10

### Added
- 9 new MCP tools (19 total): recommend_suppliers, find_alternatives, compare_suppliers, get_cluster_suppliers, check_compliance, estimate_cost, analyze_market, get_product_categories, get_province_distribution
- A2A (Agent-to-Agent) protocol support at /.well-known/agent-card.json
- MCP Server Card at /.well-known/mcp/server-card.json
- Brand transparency data: 7 brands integrated (Lululemon, Puma, New Balance, H&M, Adidas, Uniqlo, Gap Inc.)
- Database expanded to ~3,000+ suppliers from cross-referencing public brand transparency reports

### Fixed
- Province search returning 0 results (normalizeProvince now handles Chinese, English, and pinyin)
- /v1/me authentication fallback (now accepts both session cookie and Bearer token)
- Burst rate limiting (switched from async DB to in-memory sliding window)
- HTML pages missing security headers (CSP, X-Frame-Options)
- Demo endpoint leaking stack traces on error

### Security
- Added capOutput() to limit MCP tool responses to 200KB
- Removed total count from search responses (anti-scraping)
- Demo stats hardcoded (no longer exposes live database size)

### Architecture
- Code restructured from single 4175-line file to 19 modular files
- Shared query layer (db/) eliminates 3x code duplication across MCP/REST/A2A
- Reference: modelcontextprotocol/servers, github/github-mcp-server, cloudflare/agents

### Improved
- OpenAPI spec updated for all endpoints with correct response schemas
- English search support across all tool parameters
- CORS, tier filtering, log masking improvements

## [2.2.1] - 2026-04-08 [DELETED]

Removed. This version contained naming that did not meet brand guidelines.

## [2.2.0] - 2026-04-07 [DELETED]

Removed. This version contained naming that did not meet brand guidelines.

## [2.1.0] - 2026-04-01

### Added
- Initial public release of MRC Data MCP server
- 10 MCP tools: search_suppliers, get_supplier_detail, search_fabrics, get_fabric_detail, search_clusters, compare_clusters, detect_discrepancy, get_supplier_fabrics, get_fabric_suppliers, get_stats
- REST API with OpenAPI 3.1 spec
- Demo tier (no key required), Free tier, Pro tier, Enterprise tier
- AATCC / ISO / GB lab-tested fabric specifications
- MCP Registry listing with DNS-verified namespace
- Smithery and PulseMCP directory listings
