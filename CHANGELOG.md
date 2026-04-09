# Changelog

All notable changes to MRC Data are documented in this file.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [2.2.2] - 2026-04-09

### Fixed
- English search support -- all tool parameters now accept English queries (province names, product categories, fabric types) alongside Chinese
- CORS headers -- added proper CORS configuration for browser-based MCP clients and OpenAPI interactive docs
- Tier filtering -- API key tier validation now correctly enforces rate limits across all endpoints
- Unicode data fix -- resolved encoding issues in supplier names and address fields containing special CJK characters
- Log masking -- API keys and user tokens are now fully redacted in server logs

### Improved
- OpenAPI spec -- added detailed parameter descriptions, example values, and response schemas for all 10 endpoints
- Analytics tracking -- added anonymous usage metrics per tool and tier for capacity planning

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
