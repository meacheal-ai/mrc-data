#!/bin/bash
# MRC Data API — Quick smoke tests
# Usage: bash test-api.sh [API_KEY]
# Without key: tests demo endpoint only
# With key: tests all endpoints

BASE="https://api.meacheal.ai"
KEY="${1:-}"
PASS=0
FAIL=0

if [ -n "$KEY" ]; then
  echo "=== MRC Data API Tests (authenticated) ==="
else
  echo "=== MRC Data API Tests (demo only) ==="
  echo "Tip: pass API key as argument for full tests"
fi
echo ""

# check allows non-2xx responses (e.g. 404 for not-found tests)
check() {
  local desc="$1" url="$2" expected="$3"
  local resp
  if [ -n "$KEY" ]; then
    resp=$(curl -s "$url" -H "Authorization: Bearer $KEY" 2>/dev/null)
  else
    resp=$(curl -s "$url" 2>/dev/null)
  fi
  if [ -z "$resp" ]; then
    echo "FAIL: $desc — empty response"
    FAIL=$((FAIL+1))
    return
  fi
  if echo "$resp" | python3 -c "import sys,json; d=json.load(sys.stdin); $expected" 2>/dev/null; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc — assertion failed"
    echo "      Response: $(echo "$resp" | head -c 200)"
    FAIL=$((FAIL+1))
  fi
}

# Demo endpoint (always works, no key)
check "demo endpoint" \
  "$BASE/demo" \
  "assert d['total_matches']>0 and len(d['data'])>0"

if [ -z "$KEY" ]; then
  echo ""
  echo "=== Results: $PASS passed, $FAIL failed (demo only) ==="
  echo "Run with API key for full tests: bash test-api.sh YOUR_KEY"
  exit 0
fi

# --- Step 1: discover real IDs ---
echo "(discovering real IDs...)"
SUPPLIER_ID=$(curl -s "$BASE/v1/suppliers?limit=1" -H "Authorization: Bearer $KEY" | python3 -c "import sys,json; print(json.load(sys.stdin)['data'][0]['supplier_id'])" 2>/dev/null)
FABRIC_ID=$(curl -s "$BASE/v1/fabrics?limit=1" -H "Authorization: Bearer $KEY" | python3 -c "import sys,json; print(json.load(sys.stdin)['data'][0]['fabric_id'])" 2>/dev/null)
CLUSTER_IDS=$(curl -s "$BASE/v1/clusters?limit=2" -H "Authorization: Bearer $KEY" | python3 -c "import sys,json; print(','.join([c['cluster_id'] for c in json.load(sys.stdin)['data']]))" 2>/dev/null)

echo "  supplier: $SUPPLIER_ID | fabric: $FABRIC_ID | clusters: $CLUSTER_IDS"
echo ""

# --- Search tools ---
check "search_suppliers — province filter" \
  "$BASE/v1/suppliers?province=guangdong&limit=3" \
  "assert len(d['data'])>0 and len(d['data'])<=3"

check "search_suppliers — product_type filter" \
  "$BASE/v1/suppliers?product_type=sportswear&limit=5" \
  "assert 'data' in d and 'has_more' in d"

check "search_suppliers — pagination" \
  "$BASE/v1/suppliers?limit=2&offset=0" \
  "assert d['limit']==2 and isinstance(d['has_more'],bool)"

check "search_fabrics — category filter" \
  "$BASE/v1/fabrics?category=knit&limit=3" \
  "assert all(f['category']=='knit' for f in d['data'])"

check "search_fabrics — weight range" \
  "$BASE/v1/fabrics?min_weight_gsm=150&max_weight_gsm=250&limit=5" \
  "assert 'data' in d and 'has_more' in d"

check "search_fabrics — composition" \
  "$BASE/v1/fabrics?composition=cotton&limit=3" \
  "assert 'data' in d and len(d['data'])>0"

check "search_clusters — province filter" \
  "$BASE/v1/clusters?province=zhejiang&limit=3" \
  "assert 'data' in d and 'has_more' in d"

# --- Detail tools (use real IDs) ---
check "get_supplier_detail — valid ID" \
  "$BASE/v1/suppliers/$SUPPLIER_ID" \
  "assert d['data']['supplier_id']=='$SUPPLIER_ID'"

check "get_supplier_detail — invalid ID → actionable error" \
  "$BASE/v1/suppliers/NONEXISTENT_99999" \
  "assert 'error' in d or ('error' in str(d))"

check "get_fabric_detail — valid ID" \
  "$BASE/v1/fabrics/$FABRIC_ID" \
  "assert d['data']['fabric_id']=='$FABRIC_ID'"

check "get_fabric_detail — invalid ID → actionable error" \
  "$BASE/v1/fabrics/NONEXISTENT_99999" \
  "assert 'error' in d or ('error' in str(d))"

check "get_stats — database overview" \
  "$BASE/v1/stats" \
  "assert 'tables' in d and 'suppliers' in d['tables']"

# --- Cross-reference tools ---
check "get_supplier_fabrics" \
  "$BASE/v1/suppliers/$SUPPLIER_ID/fabrics" \
  "assert d['supplier_id']=='$SUPPLIER_ID'"

check "get_fabric_suppliers" \
  "$BASE/v1/fabrics/$FABRIC_ID/suppliers" \
  "assert d['fabric_id']=='$FABRIC_ID'"

# --- compare_clusters (GET with ids param) ---
check "compare_clusters" \
  "$BASE/v1/clusters/compare?ids=$CLUSTER_IDS" \
  "assert d['count']==2"

# --- detect_discrepancy (GET with field param) ---
check "detect_discrepancy — fabric_weight" \
  "$BASE/v1/discrepancy?field=fabric_weight&min_discrepancy_pct=5" \
  "assert d['field']=='fabric_weight'"

check "detect_discrepancy — invalid field → actionable error" \
  "$BASE/v1/discrepancy?field=invalid_field" \
  "assert 'error' in d or ('error' in str(d))"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
