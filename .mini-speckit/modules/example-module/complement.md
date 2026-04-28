# Example Module Complement

## Closed-Loop Workflow

This module must follow:

```text
Spec → Plan → Checklist → Align → Implement → Test
```

## Spec

- Clarify the module's pattern, responsibilities, boundaries, and non-goals.
- If user requirements conflict with module boundaries, update the spec or request confirmation first.
- Do not enter implementation until the spec is clear.

## Plan

- Break implementation into executable, verifiable, minimally scoped steps.
- The plan must state which files or capability boundaries will be touched.
- If the plan conflicts with the spec, fix the plan or spec first.

## Checklist

- The checklist must cover critical functionality, boundary conditions, and failure paths.
- The checklist must be able to verify the key steps in the plan.
- If the checklist is missing, fill it in first.

## Align

- Check whether `spec.md`, `plan.md`, `checklist.md` are mutually consistent.
- If inconsistencies are found, only the spec, plan, or checklist may be modified.
- During Align: **no code**, no implementation file changes, no unrelated refactoring.
- After alignment is complete, state explicitly in the execution notes: spec, plan, and checklist are consistent.

## Implement

- Code may only be modified after Align is complete.
- Implement strictly within the minimal scope defined in `plan.md`.
- Do not implement anything explicitly excluded by `spec.md`.
- If new conflicts are discovered, stop implementation and return to Align.

## Test

- Perform minimal relevant verification per `checklist.md`.
- Distinguish between code failures, environment failures, permission failures, and external service failures.
- The final report must list changed files, verification commands, results, and remaining risks.

## Core Principle

**No alignment, no code.**
