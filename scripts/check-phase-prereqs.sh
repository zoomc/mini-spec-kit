#!/usr/bin/env bash
set -euo pipefail

PHASE=""
MODULE=""
PROJECT_ROOT=""

usage() {
  echo "Usage: $0 --phase <1-6> --module <name> --project-root <path>"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --phase) PHASE="$2"; shift 2 ;;
    --module) MODULE="$2"; shift 2 ;;
    --project-root) PROJECT_ROOT="$2"; shift 2 ;;
    *) usage ;;
  esac
done

[[ -z "$PHASE" || -z "$MODULE" || -z "$PROJECT_ROOT" ]] && usage

MODULE_DIR="$PROJECT_ROOT/modules/$MODULE"
SPEC_FILE="$MODULE_DIR/spec.md"
PLAN_FILE="$MODULE_DIR/plan.md"
CHECKLIST_FILE="$MODULE_DIR/checklist.md"

fail() {
  echo "FAIL: $1"
  exit 1
}

check_file_exists() {
  [[ -f "$1" ]] || fail "Missing file: $1"
}

check_section() {
  local file="$1"
  local section="$2"
  grep -q "$section" "$file" || fail "$file missing section: $section"
}

check_req_items() {
  local file="$1"
  grep -qE 'REQ-[0-9]+' "$file" || fail "$file has no REQ-XXX items"
}

check_unchecked() {
  local file="$1"
  if grep -qE '^\s*- \[x\]' "$file"; then
    fail "$file has pre-checked items (must all be [ ])"
  fi
}

check_analysis_pass() {
  local file="$1"
  grep -qE 'Status.*PASS' "$file" || fail "$file Analysis Report status is not PASS"
}

case "$PHASE" in
  1)
    echo "Phase 1 (Specify) checks..."
    check_file_exists "$PROJECT_ROOT/.mini-spec-kit/project-constraints.md"
    echo "PASS"
    ;;
  2)
    echo "Phase 2 (Plan) checks..."
    check_file_exists "$SPEC_FILE"
    check_section "$SPEC_FILE" "## Requirements"
    check_req_items "$SPEC_FILE"
    echo "PASS"
    ;;
  3)
    echo "Phase 3 (Checklist) checks..."
    check_file_exists "$SPEC_FILE"
    check_file_exists "$PLAN_FILE"
    check_section "$PLAN_FILE" "## Task List"
    echo "PASS"
    ;;
  4)
    echo "Phase 4 (Analyze) checks..."
    check_file_exists "$SPEC_FILE"
    check_file_exists "$PLAN_FILE"
    check_file_exists "$CHECKLIST_FILE"
    check_unchecked "$CHECKLIST_FILE"
    echo "PASS"
    ;;
  5)
    echo "Phase 5 (Implement) checks..."
    check_file_exists "$SPEC_FILE"
    check_file_exists "$PLAN_FILE"
    check_file_exists "$CHECKLIST_FILE"
    check_unchecked "$CHECKLIST_FILE"
    check_file_exists "$PLAN_FILE"
    check_analysis_pass "$PLAN_FILE"
    echo "PASS"
    ;;
  6)
    echo "Phase 6 (Reconcile) checks..."
    check_file_exists "$SPEC_FILE"
    check_file_exists "$PLAN_FILE"
    check_file_exists "$CHECKLIST_FILE"
    echo "PASS"
    ;;
  *)
    fail "Invalid phase: $PHASE (must be 1-6)"
    ;;
esac
