#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 /absolute/path/to/target-project" >&2
  exit 1
fi

TARGET_DIR="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

require_source() {
  if [ ! -e "$TEMPLATE_DIR/$1" ]; then
    echo "Required mini-spec-kit source is missing: $TEMPLATE_DIR/$1" >&2
    exit 1
  fi
}

# ── Validate required sources ────────────────────────────────────────
require_source ".mini-spec-kit/project-constraints.md"
require_source ".mini-spec-kit/project-spec.md"
require_source "shared/coding-principles.md"
require_source "shared/workflow-overview.md"
require_source "commands/specify.md"
require_source "scripts/minispec-gate.sh"

PROJECT_NAME="$(basename "$TARGET_DIR")"

# ── 1. Copy core spec-kit files ──────────────────────────────────────
mkdir -p "$TARGET_DIR/.mini-spec-kit"
cp -R "$TEMPLATE_DIR/.mini-spec-kit" "$TARGET_DIR/.mini-spec-kit"
echo "Copied .mini-spec-kit/"

# ── 2. Copy gate scripts ─────────────────────────────────────────────
mkdir -p "$TARGET_DIR/scripts"
cp "$TEMPLATE_DIR/scripts/minispec-gate.sh" "$TARGET_DIR/scripts/minispec-gate.sh"
chmod +x "$TARGET_DIR/scripts/minispec-gate.sh"
echo "Copied gate scripts"

# ── 3. Generate context files from shared sources ────────────────────
generate_context_file() {
  local target_file="$1"
  local agent_type="$2"

  if [ -f "$target_file" ]; then
    echo "$target_file already exists, skipping."
    return
  fi

  {
    echo "# Project: $PROJECT_NAME"
    echo ""
    echo "## AI Coding Rules"
    echo ""
    echo "**All git-diff-producing changes MUST follow the mini-spec-kit 6-phase workflow.**"
    echo ""
    echo "1. Read \`.mini-spec-kit/project-constraints.md\` first"
    echo "2. Follow the workflow: Specify → Plan → Write Checklist → Analyze → Implement → Reconcile"
    echo "3. Phase gates are enforced by file checks — do NOT skip phases"
    echo "4. Do NOT modify code before the Analyze phase passes"
    echo ""
    cat "$TEMPLATE_DIR/shared/coding-principles.md"
    echo ""
    echo "## Architecture"
    echo ""
    echo "<!-- TODO: Fill in your project structure here -->"
    echo ""
    echo "## Key Commands"
    echo ""
    echo "<!-- TODO: Fill in build/test commands -->"
    echo ""
    echo "## Code Standards"
    echo ""
    echo "<!-- TODO: Fill in coding conventions -->"
    echo ""
    echo "## Process Enforcement"
    echo ""
    echo "**Any change that produces a git diff, including a one-line text edit, must satisfy all of these conditions:**"
    echo ""
    echo "1. Run the complete mini-spec-kit flow: Specify → Plan → Checklist → Analyze → Implement → Reconcile."
    echo "2. Keep \`checklist.md\` unchecked before Implement; check items only during Reconcile."
    echo "3. Use \`scripts/minispec-gate.sh\` to verify gates."
    echo ""
    echo "**Violating any condition makes the task invalid and requires returning to the missing phase.**"
    echo ""
    cat "$TEMPLATE_DIR/shared/workflow-overview.md"
  } > "$target_file"

  echo "Created $target_file"
}

generate_context_file "$TARGET_DIR/CLAUDE.md" "claude"
generate_context_file "$TARGET_DIR/AGENTS.md" "agents"

# ── 4. Generate commands for all three agents ────────────────────────
generate_commands() {
  local src="$TEMPLATE_DIR/commands"

  # Claude Code: .claude/commands/*.md
  mkdir -p "$TARGET_DIR/.claude/commands"
  for f in "$src"/*.md; do
    name=$(basename "$f")
    if [ ! -f "$TARGET_DIR/.claude/commands/$name" ]; then
      cp "$f" "$TARGET_DIR/.claude/commands/$name"
    fi
  done
  echo "Generated Claude Code commands (.claude/commands/)"

  # Codex: .agents/skills/speckit-<name>/SKILL.md
  mkdir -p "$TARGET_DIR/.agents/skills"
  for f in "$src"/*.md; do
    name=$(basename "$f" .md)
    dir="$TARGET_DIR/.agents/skills/speckit-$name"
    if [ ! -f "$dir/SKILL.md" ]; then
      mkdir -p "$dir"
      cp "$f" "$dir/SKILL.md"
    fi
  done
  echo "Generated Codex skills (.agents/skills/)"

  # Copilot: .github/agents/speckit.<name>.agent.md
  mkdir -p "$TARGET_DIR/.github/agents"
  for f in "$src"/*.md; do
    name=$(basename "$f" .md)
    target="$TARGET_DIR/.github/agents/speckit.$name.agent.md"
    if [ ! -f "$target" ]; then
      cp "$f" "$target"
    fi
  done
  echo "Generated Copilot agents (.github/agents/)"
}

generate_commands

# ── 5. Generate Copilot instructions (thin shell) ────────────────────
mkdir -p "$TARGET_DIR/.github"
if [ ! -f "$TARGET_DIR/.github/copilot-instructions.md" ]; then
  cat > "$TARGET_DIR/.github/copilot-instructions.md" << 'COPILOT_EOF'
# Copilot Instructions

This project uses `.mini-spec-kit/` for spec-driven development. Before modifying code:

1. Read `.mini-spec-kit/project-constraints.md`
2. Read `.mini-spec-kit/project-spec.md`
3. Read the target module's files in `.mini-spec-kit/modules/<module>/`

## Workflow

Follow the 6-phase workflow for any change that produces a git diff:

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

## Rules

- **No alignment, no code**: `spec.md`, `plan.md`, `checklist.md` must be consistent before implementation.
- **No pre-checked checklists**: All checklist items start as `[ ]`.
- **Reconcile is mandatory**: After implementation, update spec files to match code and pass the final gate.
- **Hard gates**: Use `scripts/minispec-gate.sh`; inspect `.mini-spec-kit/modules/<module>`.
- **Completion**: A module is complete only when `scripts/minispec-gate.sh --phase final --module <module> --project-root .` exits 0.
COPILOT_EOF
  echo "Created .github/copilot-instructions.md"
fi

# ── 6. Generate manifest ─────────────────────────────────────────────
generate_manifest() {
  local manifest="$TARGET_DIR/speckit.manifest.json"
  local timestamp
  timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

  echo "{" > "$manifest"
  echo "  \"version\": \"2.0.0\"," >> "$manifest"
  echo "  \"installed_at\": \"$timestamp\"," >> "$manifest"
  echo "  \"files\": {" >> "$manifest"

  local first=true
  for f in \
    "$TARGET_DIR/CLAUDE.md" \
    "$TARGET_DIR/AGENTS.md" \
    "$TARGET_DIR/.github/copilot-instructions.md" \
    "$TARGET_DIR/scripts/minispec-gate.sh" \
    "$TARGET_DIR/.claude/commands/"*.md \
    "$TARGET_DIR/.github/agents/"*.md \
    "$TARGET_DIR/.mini-spec-kit/project-constraints.md" \
    "$TARGET_DIR/.mini-spec-kit/project-spec.md"; do
    [ -f "$f" ] || continue
    local rel
    rel="$(echo "$f" | sed "s|$TARGET_DIR/||")"
    local hash
    hash="$(shasum -a 256 "$f" | cut -d' ' -f1)"
    if [ "$first" = true ]; then
      first=false
    else
      echo "," >> "$manifest"
    fi
    printf '    "%s": "%s"' "$rel" "$hash" >> "$manifest"
  done

  echo "" >> "$manifest"
  echo "  }" >> "$manifest"
  echo "}" >> "$manifest"

  echo "Generated speckit.manifest.json"
}

generate_manifest

# ── Done ──────────────────────────────────────────────────────────────
echo ""
echo "mini-spec-kit v2 initialized in: $TARGET_DIR"
echo "Installed: .mini-spec-kit, .claude/commands, .agents/skills, .github/agents, AGENTS.md, CLAUDE.md, scripts/, speckit.manifest.json"
echo "Next: read .mini-spec-kit/project-constraints.md before editing code."
