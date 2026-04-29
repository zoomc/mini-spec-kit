# mini-speckit

**Stop letting AI agents write code without a plan.**

`mini-spec` is a lightweight Spec-Driven Development framework that forces AI coding agents to think before they code. It's the minimum viable process that prevents AI from going off-track, introducing bugs, or building the wrong thing.

## The Problem

AI coding agents are powerful but impatient. Give them a task, and they'll start writing code immediately — often before understanding what you actually want. The result?

- ❌ Code that doesn't match your requirements
- ❌ Endless back-and-forth fixing issues that shouldn't have existed
- ❌ No documentation of what was built or why
- ❌ Scope creep and feature drift

## The Solution

`mini-spec` enforces a simple 6-phase workflow:

```
Specify → Plan → Write Checklist → Analyze → Implement → Reconcile
```

**Before any code is written**, the agent must:
1. ✅ Define requirements with traceable IDs
2. ✅ Create an implementation plan
3. ✅ Write verification checklists
4. ✅ Analyze for consistency and gaps
5. ✅ Only THEN write code
6. ✅ Verify and update specs to match reality

**The spec document is the source of truth. Code serves specs.**

## Why It Works

| Principle | Benefit |
|-----------|---------|
| **Spec is king** | Code implements the spec, not the other way around |
| **Artifact gates** | Each phase produces files the next phase requires — skip a phase and you can't proceed |
| **No pre-checked boxes** | Every verification starts as `[ ]`, forcing actual testing |
| **Change tracking** | Every modification is logged with requirement IDs |
| **Reconcile mandate** | After coding, specs must be updated to reflect reality |

## 6-Phase Workflow

| Phase | What Happens | Output |
|-------|--------------|--------|
| **1. Specify** | Define what to build with requirement IDs | `spec.md` with `<!-- REQ-XXX -->` markers |
| **2. Plan** | Break down into tasks with dependencies | `plan.md` with `## Task List` |
| **3. Checklist** | Create verification commands for each task | `checklist.md` with `[ ]` items |
| **4. Analyze** | Read-only consistency check | `plan.md` with `## Analysis Report` |
| **5. Implement** | Write code according to plan | Working code + passing tests |
| **6. Reconcile** | Verify everything, update specs | `checklist.md` all `[x]` + `changelog.md` |

## Phase Gates (Anti-Skip Mechanism)

Each phase has a **physical gate** — a file check that must pass before the next phase can start:

```
Specify → [spec.md has ## Requirements?] → Plan
Plan → [plan.md has ## Task List?] → Checklist
Checklist → [checklist.md has [ ] items?] → Analyze
Analyze → [plan.md has ## Analysis Report?] → Implement
Implement → [Build/test passes?] → Reconcile
Reconcile → [All [x], spec matches code?] → Done
```

**Skip a gate? The workflow stops.** No shortcuts, no "we'll fix it later."

## Quick Start

### Initialize in Your Project

```bash
git clone https://github.com/zoomc/mini-speckit.git
cd mini-speckit
./scripts/init-mini-speckit.sh /path/to/your/project
```

This copies the `.mini-speckit/` template into your project.

### Use with AI Agents

1. Your AI agent reads `.mini-speckit/project-constraints.md`
2. Follows the 6-phase workflow for each task
3. Produces traceable, verifiable results

## Directory Structure

```
your-project/
  .mini-speckit/
    project-constraints.md    # Workflow rules and constraints
    project-spec.md           # Project goals and data flow
    modules/
      <module-name>/
        spec.md               # Current requirements (with REQ-XXX IDs)
        plan.md               # Implementation plan + Analysis Report
        checklist.md          # Verification items with commands
        complement.md         # Module responsibilities
        changelog.md          # Change history
```

## Change Management

| Type | spec.md | changelog.md |
|------|---------|-------------|
| Bug Fix | No change (or `## Known Issues`) | Record fix |
| Requirement Change | Mark `[CHANGED]` / `[DEPRECATED]` | Record change |
| Enhancement | Add `[NEW]` section | Record addition |
| Refactoring | No change (behavior preserved) | Record refactor |

## Who Is This For?

- **AI coding agents** (Claude, GPT, Copilot, Cursor, etc.) — gives them a structured workflow to follow
- **Developers using AI** — ensures AI output matches your requirements
- **Teams** — creates documentation trail for every change
- **Solo developers** — prevents your own scope creep

## Real-World Example

**Before mini-spec:**
> "Hey AI, build a user authentication system"
> → AI writes 500 lines of code
> → You discover it doesn't handle password reset
> → Back and forth for hours

**With mini-spec:**
> Phase 1: "Requirements: login, logout, password reset, email verification"
> Phase 2: "Plan: 4 tasks, each ~100 lines, dependencies mapped"
> Phase 3: "Checklist: 8 verification commands ready"
> Phase 4: "Analysis: no gaps found"
> Phase 5: "Implement: code matches plan exactly"
> Phase 6: "Reconcile: all verified, specs updated"

**Total time saved: hours of rework.**

## License

MIT

## Credits

Inspired by the official Spec Kit methodology. This is the minimal, portable version.
