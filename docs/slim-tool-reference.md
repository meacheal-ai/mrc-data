# MRC Data -- Slim Tool Reference

Minimal 3-tool subset for token-constrained agents. Full reference: [tool-reference.md](tool-reference.md)

---

### `search_suppliers`

Find apparel suppliers in China. Parameters: `province`, `city`, `type`, `product_type`, `min_capacity`, `compliance_status`, `limit`, `offset`. All optional.

### `search_fabrics`

Find lab-tested fabrics. Parameters: `category`, `min_weight_gsm`, `max_weight_gsm`, `composition`, `max_price_rmb`, `suitable_for`, `limit`, `offset`. All optional.

### `get_stats`

Database overview: record counts and verification coverage. No parameters.

---

These 3 tools cover basic discovery. For supplier/fabric details, cross-references, compliance checks, and cost estimation, use the full 18-tool set.
