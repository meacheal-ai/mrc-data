# MRC Data -- Tool Reference

Complete reference for all 19 MCP tools. For a minimal subset, see [slim-tool-reference.md](slim-tool-reference.md).

---

## Search tools

### `search_suppliers`

Filter suppliers by location, type, capacity, product category, compliance, and quality.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `province` | string | no | Province name (e.g. `guangdong`, `zhejiang`) |
| `city` | string | no | City name (e.g. `guangzhou`, `shaoxing`) |
| `type` | string | no | `factory` / `trading_company` / `workshop` / `cooperative` |
| `product_type` | string | no | Product keyword (e.g. `sportswear`, `denim`, `down jacket`) |
| `min_capacity` | integer | no | Minimum monthly capacity (pieces) |
| `compliance_status` | string | no | `compliant` / `partially_compliant` / `improvement_needed` / `unknown` |
| `data_confidence` | string | no | `verified` / `partially_verified` / `unverified` |
| `min_quality_score` | float | no | Minimum quality score (1-10) |
| `limit` | integer | no | Results per page (default 10, max 50) |
| `offset` | integer | no | Skip N results for pagination |

**Returns:** Paginated list with `total`, `has_more`, and summary fields per supplier.

---

### `search_fabrics`

Filter fabrics by category, weight range, composition, price, and target product.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `category` | string | no | `woven` / `knit` / `nonwoven` / `leather` / `fur` / `functional` |
| `min_weight_gsm` | float | no | Minimum weight (g/m²) |
| `max_weight_gsm` | float | no | Maximum weight (g/m²) |
| `composition` | string | no | Composition keyword (e.g. `cotton`, `polyester`, `silk`) |
| `data_confidence` | string | no | `verified` / `partially_verified` / `unverified` |
| `max_price_rmb` | float | no | Maximum price (RMB/meter) |
| `suitable_for` | string | no | Target product keyword (e.g. `t-shirt`, `suit`, `dress`) |
| `limit` | integer | no | Results per page (default 10, max 50) |
| `offset` | integer | no | Skip N results for pagination |

**Returns:** Paginated list with lab-tested weight, composition, price range, and confidence level.

---

### `search_clusters`

Filter industrial clusters by province, type, specialization, and scale.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `province` | string | no | Province name |
| `type` | string | no | `fabric_market` / `garment_manufacturing` / `accessories` / `integrated` |
| `specialization` | string | no | Specialization keyword (e.g. `womenswear`, `denim`, `leather`) |
| `scale` | string | no | `mega` / `large` / `medium` / `small` |
| `limit` | integer | no | Results per page (default 10, max 50) |
| `offset` | integer | no | Skip N results for pagination |

**Returns:** Paginated list with supplier count, labor cost, and cluster metadata.

---

## Detail tools

### `get_supplier_detail`

Full 50+ field profile of a single supplier.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `supplier_id` | string | **yes** | Supplier ID (e.g. `sup_001`) |

**Returns:** Complete supplier record including capacity, equipment, certifications, compliance status, market access, environmental data, and lab-test cross-references.

**If not found:** Returns actionable error with suggestion to use `search_suppliers`.

---

### `get_fabric_detail`

Full lab-tested record with 30+ specifications for a single fabric.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `fabric_id` | string | **yes** | Fabric ID (e.g. `fab_001`) |

**Returns:** Complete fabric record including weight (declared + tested), composition (declared + tested), color fastness, shrinkage, tensile strength, price range, and suitable products.

**If not found:** Returns actionable error with suggestion to use `search_fabrics`.

---

### `get_stats`

Database overview: record counts, verification coverage, last update timestamps.

No parameters required.

---

## Cross-reference tools

### `get_supplier_fabrics`

All fabrics offered by a specific supplier, with pricing, MOQ, and lead time.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `supplier_id` | string | **yes** | Supplier ID |

---

### `get_fabric_suppliers`

All suppliers of a specific fabric, ranked by quality score, with pricing comparison.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `fabric_id` | string | **yes** | Fabric ID |

---

### `compare_clusters`

Side-by-side comparison of multiple clusters on scale, rent, logistics, and labor cost.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `cluster_ids` | string[] | **yes** | List of cluster IDs (e.g. `["clu_001", "clu_002"]`) |

---

### `compare_suppliers`

Side-by-side comparison of multiple suppliers on capacity, quality, compliance, and pricing.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `supplier_ids` | string[] | **yes** | List of supplier IDs (max 10) |

---

### `get_cluster_suppliers`

List all suppliers in a specific industrial cluster, sorted by quality score.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `cluster_id` | string | **yes** | Cluster ID (e.g. `humen_women`, `keqiao_fabric`) |
| `limit` | integer | no | Results per page (default 20, max 50) |
| `offset` | integer | no | Skip N results for pagination |

**Returns:** Paginated supplier list with `has_more`, sorted by quality score descending.

---

## Intelligence tools

### `detect_discrepancy`

Surface specs where declared values deviate from lab-test results. Core verification capability.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `field` | string | **yes** | `fabric_weight` / `fabric_composition` / `supplier_capacity` / `worker_count` |
| `min_discrepancy_pct` | float | no | Minimum deviation threshold (%, default 0) |

**Returns:** Records sorted by discrepancy percentage, with both declared and tested values.

---

### `check_compliance`

Check if a supplier meets compliance requirements for a target export market.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `supplier_id` | string | **yes** | Supplier ID |
| `target_market` | string | no | Target market (e.g. `eu`, `us`, `japan`) |

---

### `recommend_suppliers`

Smart supplier recommendation based on sourcing requirements.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `product_type` | string | **yes** | Product category |
| `quantity` | integer | no | Monthly quantity needed |
| `target_market` | string | no | Export destination |
| `priority` | string | no | `quality` / `price` / `speed` / `compliance` |

---

### `find_alternatives`

Find alternative suppliers similar to a given supplier.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `supplier_id` | string | **yes** | Reference supplier ID |
| `limit` | integer | no | Max results (default 5) |

---

### `estimate_cost`

Estimate sourcing cost for a product based on fabric, quantity, and supplier location.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `product_type` | string | **yes** | Product category |
| `fabric_id` | string | no | Specific fabric ID |
| `quantity` | integer | no | Order quantity |

---

### `analyze_market`

Market overview for a product category: supplier distribution, price ranges, capacity.

| Parameter | Type | Required | Description |
|---|---|---|---|
| `product_type` | string | **yes** | Product category |

---

### `get_product_categories`

List all product categories available in the database.

No parameters required.

---

### `get_province_distribution`

Show supplier distribution across Chinese provinces.

No parameters required.

---

## Response format

All tools return JSON with consistent structure:

```json
{
  "total": 42,
  "limit": 10,
  "offset": 0,
  "has_more": true,
  "data": [ ... ],
  "attribution": "MRC Data (meacheal.ai)"
}
```

Detail tools return:

```json
{
  "data": { ... },
  "attribution": "MRC Data (meacheal.ai)"
}
```

Error responses include actionable next steps:

```json
{
  "error": "Supplier 'sup_999' not found.",
  "suggestion": "Use search_suppliers to find valid supplier IDs.",
  "example": "search_suppliers(province='guangdong', product_type='sportswear')"
}
```
