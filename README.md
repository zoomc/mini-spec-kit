# mini-speckit

`mini-speckit` is a minimal, copyable Spec-Driven Development base template.

It does not copy the official Spec Kit implementation — only the core idea: align constraints, specs, plans, and checklists before letting AI coding tools enter the implementation phase.

## Core Principles

- **Define first, implement later**: Before any code change, clarify project constraints, module specs, implementation plan, and checkpoints.
- **No alignment, no code**: `spec.md`, `plan.md`, `checklist.md` must be consistent; when inconsistent, fix docs only — no code.
- **Files are context**: Key decisions live in `.mini-speckit/`, reducing reliance on chat history.
- **Copy to use**: Place `.mini-speckit/` and `.github/copilot-instructions.md` into any project root, and AI tools read the same constraints.

## Workflow

1. Read `.mini-speckit/project-constraints.md`
2. Read `.mini-speckit/project-spec.md`
3. Select a module and read `.mini-speckit/modules/<module>/complement.md`
4. Follow the module workflow: `Spec → Plan → Checklist → Align → Implement → Test`

## Initialize into Another Project

```bash
./scripts/init-mini-speckit.sh /absolute/path/to/target-project
```

The script copies:

- `.mini-speckit/`
- `.github/copilot-instructions.md`

## Directory Structure

```text
mini-speckit/
  README.md
  .gitignore
  .mini-speckit/
    project-constraints.md
    project-spec.md
    modules/
      example-module/
        spec.md
        plan.md
        checklist.md
        complement.md
  .github/
    copilot-instructions.md
  scripts/
    init-mini-speckit.sh
```

## Relationship with Official Spec Kit

The official Spec Kit provides a full CLI, templates, scripts, and multi-agent workflows. This project keeps only the minimum portable idea: freeze constraints and workflow into project files so any AI coding executor completes spec alignment before writing code.
