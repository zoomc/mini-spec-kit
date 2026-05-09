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

```text
Specify → Plan → Checklist → Analyze → Implement → Reconcile
```

Any task that produces a `git diff` must pass all six phases. Tiny tasks can use tiny artifacts — **not skipped discipline**.

## Anti-Skip Gates

Physical file checks prevent phase skipping:

```text
spec.md has ## Requirements? → Proceed to Plan
plan.md has ## Task List? → Proceed to Checklist
checklist.md exists + has verification items? → Proceed to Analyze
Analysis passed + checklist [ ] only + gate allows Implement? → Proceed to Implement
Build/test passes + git diff exists? → Proceed to Reconcile
All [x], spec matches code, logs updated, final gate passes? → Done
```

Use the hard gate script when available:

```bash
./scripts/minispec-gate.sh --phase before-implement --module <module> --project-root .
./scripts/minispec-gate.sh --phase final --module <module> --project-root .
```

**Complete means the final gate passes.** A module is not complete merely because `spec.md`, `plan.md`, and `checklist.md` exist.

Compatibility checker remains available:

```bash
./scripts/check-phase-prereqs.sh --phase 5 --module <module> --project-root .
```

Both scripts inspect `.mini-spec-kit/modules/<module>`.

## Gate Files

- `gate.md`: workflow status + implementation permission
- `checklist.md`: business verification checklist
- `verify.log`: verification command results
- `gate-history.log`: lightweight gate transitions

## Quick Start

```bash
git clone https://github.com/zoomc/mini-spec-kit.git
cd mini-spec-kit
./scripts/init-mini-speckit.sh /path/to/your/project
```

This copies `.mini-spec-kit/`, `.github/copilot-instructions.md`, `.claude/commands/`, `.agents/skills/`, `AGENTS.md`, `CLAUDE.md`, and gate scripts in `scripts/` into your project.

## Who Is This For?

- **Solo devs with AI copilots** who want fewer rewrites and cleaner delivery
- **Small teams** that need accountability without enterprise overhead
- **AI agents** that perform better with explicit constraints and structure

## mini-spec-kit vs. Official Spec Kit

| | mini-spec-kit | Official Spec Kit |
|-|---------------|-------------------|
| **Setup** | Copy one folder | Full CLI + templates |
| **Learning curve** | ~5 minutes | Hours |
| **Token overhead** | Minimal | Higher |
| **Best for** | Individuals, small teams | Enterprise, large teams |

## License

MIT
