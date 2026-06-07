# mini-spec-kit

[🇺🇸 English](README.md) | [🇨🇳 中文](README.zh-CN.md)

<div align="center">

![mini-spec-kit banner](https://img.shields.io/badge/AI%20Spec--Driven-Ship%20Faster%20with%20Less%20Rework-111827?style=for-the-badge)
![License](https://img.shields.io/github/license/zoomc/mini-spec-kit?style=for-the-badge)
![Stars](https://img.shields.io/github/stars/zoomc/mini-spec-kit?style=for-the-badge)
![Workflow](https://img.shields.io/badge/Workflow-6%20Phases-2563eb?style=for-the-badge)

### **Stop vibe-coding chaos. Start shipping with proof.**

</div>

**Spec-driven development for AI coding agents — lightweight, traceable, token-efficient.**

`mini-spec-kit` is a minimal Spec-Driven Development framework for solo developers and small teams using AI coding agents. It enforces a clear 6-phase workflow so your code moves fast **without becoming fragile, undocumented, or untraceable**.

## About

> **Build with AI like a pro: lock requirements, control execution, verify outcomes, and ship with confidence.**

Suggested GitHub About line:

> **Spec-driven AI coding workflow for shipping fast with less rework.**

## Why mini-spec-kit?

AI coding agents are powerful, but without process they often:

- Write code before understanding real requirements
- Introduce regressions that cause expensive rework
- Lose context between sessions
- Generate changes no one can reliably audit

**mini-spec-kit turns that chaos into momentum** with lightweight, enforceable gates:

| Benefit | How |
|---------|-----|
| **Stability** | Freeze requirements before code starts |
| **Traceability** | Link every change back to requirement IDs |
| **Token efficiency** | Inject only minimal, relevant context |
| **Portability** | Works with Claude, GPT, Copilot, Cursor, and more |
| **Simplicity** | 6 phases, clear gates, near-zero setup burden |

## Visual Workflow

```mermaid
flowchart LR
    S[Specify] --> P[Plan]
    P --> C[Checklist]
    C --> A[Analyze]
    A --> I[Implement]
    I --> R[Reconcile]
    R -->|Gate Pass| D[Done ✅]
```

## How It Works

```text
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

Each phase produces artifacts that the next phase requires. **Any git-diff-producing task must run all six phases.** Tiny tasks can keep artifacts short, but they do not skip the workflow.

| Phase | What Happens | Output |
|-------|--------------|--------|
| **Specify** | Define requirements with traceable IDs | `spec.md` |
| **Plan** | Break down into tasks with dependencies | `plan.md` |
| **Checklist** | Create verification commands | `checklist.md` |
| **Analyze** | Read-only consistency check | Analysis report |
| **Implement** | Write code according to plan | Working code |
| **Reconcile** | Verify and update specs | Updated docs |

## Anti-Skip Gates

Physical file checks prevent phase skipping:

```
spec.md has ## Requirements? → Proceed to Plan
plan.md has ## Task List? → Proceed to Checklist
checklist.md exists and has verification items? → Proceed to Analyze
Analysis Report passed, checklist has [ ] and no [x], gate allows Implement? → Proceed to Implement
Build/test passes and git diff exists? → Proceed to Reconcile
All [x], spec matches code, logs updated, final gate passes? → Done
```

Use the hard gate script when available:

```bash
./scripts/minispec-gate.sh --phase before-implement --module <module> --project-root .
./scripts/minispec-gate.sh --phase final --module <module> --project-root .
```

**Complete means the final gate passes.** A module is not complete merely because `spec.md`, `plan.md`, and `checklist.md` exist; it is complete only after Reconcile verifies the checklist, updates logs/changelog, and this command exits 0:

```bash
./scripts/minispec-gate.sh --phase final --module <module> --project-root .
```

## Directory Structure

```text
mini-spec-kit/
├── .mini-spec-kit/              # Core spec definitions (copied to target project)
│   ├── project-constraints.md   # Single source of truth: 6-phase rules + gates
│   ├── project-spec.md          # Project goals + module relationships
│   └── modules/<module>/        # Per-module artifacts
├── shared/                      # Shared snippets (single source, generated into targets)
│   ├── coding-principles.md     # Karpathy 4 rules (one copy)
│   └── workflow-overview.md     # 6-phase overview (one copy)
├── commands/                    # Command source (one copy, generates to 3 agents)
│   ├── specify.md
│   ├── plan.md
│   ├── checklist.md
│   ├── analyze.md
│   ├── implement.md
│   └── reconcile.md
├── scripts/
│   ├── init-mini-speckit.sh     # Init: generates from single source to CC/Codex/Copilot
│   └── minispec-gate.sh         # Hard gate enforcement
├── templates/                   # Reference templates (now generated from shared/)
│   ├── CLAUDE.md
│   └── AGENTS.md
└── README.md
```

## Quick Start

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

This generates:
- `.mini-spec-kit/` — core spec definitions
- `.claude/commands/*.md` — Claude Code slash commands
- `.agents/skills/speckit-*/SKILL.md` — Codex skills
- `.github/agents/speckit.*.agent.md` — Copilot agents
- `CLAUDE.md` + `AGENTS.md` — agent context files
- `.github/copilot-instructions.md` — Copilot instructions
- `scripts/minispec-gate.sh` — hard gate script
- `speckit.manifest.json` — file tracking manifest

Your AI agent reads the constraints and follows the workflow.

The bundled `example-module` is a pre-implementation open example. It demonstrates artifact shape and intentionally does not pass the final gate.

## Who Is This For?

- **Solo developers** using AI agents — prevent scope creep and rework
- **Small teams** — create documentation trails without overhead
- **AI agents** — structured workflow to follow

## vs. Official Spec Kit

| | mini-spec-kit | Official Spec Kit |
|-|---------------|-------------------|
| **Setup** | Copy one folder | Full CLI + templates |
| **Learning curve** | 5 minutes | Hours |
| **Token overhead** | Minimal | Higher |
| **Best for** | Individuals, small teams | Enterprise, large teams |

## License

MIT
