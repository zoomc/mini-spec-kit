# Example Module Plan

## Implementation Steps

1. Read `project-constraints.md`, `project-spec.md`, and this module's `complement.md`.
2. Based on the user task, update or confirm `spec.md` responsibilities, inputs/outputs, and boundaries.
3. Update or confirm this file's implementation steps, ensuring each step is verifiable and minimally scoped.
4. Update or confirm `checklist.md` critical functionality points, boundary conditions, and failure paths.
5. Execute Align: check whether `spec.md`, `plan.md`, `checklist.md` are consistent.
6. After Align passes, proceed with minimal code changes per the plan.
7. Execute minimal relevant tests per `checklist.md` and record results.

## Risk Control

- If the plan needs to touch files outside the module boundary, go back to `spec.md` and clarify why first.
- If a test point cannot be executed, it must be marked in the final report as environment, permission, service, or missing dependency.
- If requirement conflicts are found, only modify spec docs and request confirmation — do not enter implementation.
