# Project Spec

## Project Goal

`mini-speckit` provides a minimal, copyable AI coding spec skeleton for any project, enabling Hermes, Codex, or other executors to complete spec alignment before writing code — reducing context drift, scope creep, and premature implementation risks.

## Module Breakdown

- `project-constraints`: Project-level entry point defining AI behavior, forbidden actions, architecture constraints, and token strategy.
- `project-spec`: Project goals, module relationships, data flow, and directory structure.
- `modules/<module>`: Module-level specs, plans, checklists, and closed-loop workflow.
- `copilot-instructions`: Makes GitHub Copilot and similar tools respect `.mini-speckit/` constraints first.
- `init-script`: Copies the template into the actual project root.

## Data Flow

```text
User Task
  ↓
Read project-constraints.md
  ↓
Read project-spec.md
  ↓
Select modules/<module>/complement.md
  ↓
Spec → Plan → Checklist
  ↓
Align documents only
  ↓
Implement code
  ↓
Test by checklist
  ↓
Report result and gaps
```

## Directory Structure

```text
.mini-speckit/
  project-constraints.md
  project-spec.md
  modules/
    <module>/
      spec.md
      plan.md
      checklist.md
      complement.md
.github/
  copilot-instructions.md
scripts/
  init-mini-speckit.sh
```

## Usage Boundaries

- This project is not a replacement CLI for the official Spec Kit.
- This project does not provide code generators, template renderers, or agent orchestrators.
- This project only defines minimum spec files and closed-loop execution rules.
