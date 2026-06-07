## Workflow

This project uses the mini-spec-kit 6-phase workflow. All git-diff-producing changes MUST follow this flow:

```text
Specify → Plan → Checklist → Analyze → Implement → Reconcile
```

| Phase | Command | Purpose |
|-------|---------|---------|
| 1 | `/specify <module>: <desc>` | Create module specification |
| 2 | `/plan <module>` | Create technical implementation plan |
| 3 | `/checklist <module>` | Create verification checklist |
| 4 | `/analyze <module>` | Validate spec-plan alignment |
| 5 | `/implement <module>` | Write code per plan |
| 6 | `/reconcile <module>` | Verify and close checklist |

**Rules**:
- Each phase has gate checks — you cannot skip phases
- Do NOT modify code before Analyze passes
- Before Implement, checklist items must be `[ ]` and must not contain `[x]`
- During Reconcile, passed items become `[x]`
- Run `scripts/minispec-gate.sh --phase <phase> --module <name> --project-root .` for hard gates
- A module is complete only after `scripts/minispec-gate.sh --phase final --module <name> --project-root .` exits 0

**No exceptions. No "too small to skip".**

| Skip behavior | Result |
|---------------|--------|
| Skip Specify/Plan, jump to Implement | ❌ Rejected, output voided |
| Deliver without Reconcile | ❌ Rejected, output voided |
| Simplify flow because "change is small" | ❌ Rejected, output voided |
