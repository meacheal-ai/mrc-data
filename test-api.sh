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
  AUTH="-H \"Authorization: Bearer $KEY\""
  echo "=== MRC Data API Tests (authenticated) ==="
else
  echo "=== MRC Data API Tests (demo only) ==="
  echo "Tip: pass API key as argument for full tests"
fi
echo ""

check() {
  local desc="$1" url="$2" expected="$3"
  local resp
  if [ -n "$KEY" ]; then
    resp=$(curl -sf "$url" -H "Authorization: Bearer $KEY" 2>/dev/null)
  else
    resp=$(curl -sf "$url" 2>/dev/null)
  fi
  if [ $? -ne 0 ]; then
    echo "FAIL: $desc — HTTP error"
    FAIL=$((FAIL+1))
    return
  fi
  if echo "$resp" | python3 -c "import sys,json; d=json.load(sys.stdin); $expected" 2>/dev/null; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc — assertion failed"
    FAIL=$((FAIL+1))
  fi
}

check_post() {
  local desc="$1" url="$2" body="$3" expected="$4"
  local resp
  if [ -n "$KEY" ]; then
    resp=$(curl -sf -X POST "$url" -H "Content-Type: application/json" -H "Authorization: Bearer $KEY" -d "$body" 2>/dev/null)
  else
    resp=$(curl -sf -X POST "$url" -H "Content-Type: application/json" -d "$body" 2>/dev/null)
  fi
  if [ $? -ne 0 ]; then
    echo "FAIL: $desc — HTTP error"
    FAIL=$((FAIL+1))
    return
  fi
  if echo "$resp" | python3 -c "import sys,json; d=json.load(sys.stdin); $expected" 2>/dev/null; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc — assertion failed"
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

# Search tools
check "search_suppliers — province filter" \
  "$BASE/v1/suppliers?province=guangdong&limit=3" \
  "assert d['total']>0 and len(d['data'])<=3"

check "search_suppliers — product_type filter" \
  "$BASE/v1/suppliers?product_type=sportswear&limit=5" \
  "assert d['total']>=0"

check "search_suppliers — pagination" \
  "$BASE/v1/suppliers?limit=2&offset=0" \
  "assert d['limit']==2 and isinstance(d['has_more'],bool)"

check "search_fabrics — category filter" \
  "$BASE/v1/fabrics?category=knit&limit=3" \
  "assert all(f['category']=='knit' for f in d['data'])"

check "search_fabrics — weight range" \
  "$BASE/v1/fabrics?min_weight_gsm=150&max_weight_gsm=250&limit=5" \
  "assert d['total']>=0"

check "search_fabrics — composition" \
  "$BASE/v1/fabrics?composition=cotton&limit=3" \
  "assert d['total']>=0"

check "search_clusters — province filter" \
  "$BASE/v1/clusters?province=zhejiang&limit=3" \
  "assert d['total']>=0"

# Detail tools
check "get_supplier_detail — valid ID" \
  "$BASE/v1/suppliers/sup_001" \
  "assert d['data']['supplier_id']=='sup_001'"

check "get_supplier_detail — invalid ID → actionable error" \
  "$BASE/v1/suppliers/sup_99999" \
  "assert 'error' in d and 'suggestion' in d"

check "get_fabric_detail — valid ID" \
  "$BASE/v1/fabrics/fab_001" \
  "assert d['data']['fabric_id']=='fab_001'"

check "get_fabric_detail — invalid ID → actionable error" \
  "$BASE/v1/fabrics/fab_99999" \
  "assert 'error' in d and 'suggestion' in d"

check "get_stats — database overview" \
  "$BASE/v1/stats" \
  "assert 'tables' in d and 'suppliers' in d['tables']"

# Cross-reference tools
check "get_supplier_fabrics" \
  "$BASE/v1/suppliers/sup_001/fabrics" \
  "assert d['supplier_id']=='sup_001'"

check "get_fabric_suppliers" \
  "$BASE/v1/fabrics/fab_001/suppliers" \
  "assert d['fabric_id']=='fab_001'"

# POST tools
check_post "compare_clusters" \
  "$BASE/v1/clusters/compare" \
  '{"cluster_ids":["clu_001","clu_002"]}' \
  "assert d['count']==2"

check_post "detect_discrepancy — fabric_weight" \
  "$BASE/v1/discrepancy" \
  '{"field":"fabric_weight","min_discrepancy_pct":5}' \
  "assert d['field']=='fabric_weight'"

check_post "detect_discrepancy — invalid field → actionable error" \
  "$BASE/v1/discrepancy" \
  '{"field":"invalid_field"}' \
  "assert 'error' in d and 'suggestion' in d"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
