# Example Module Checklist

## Critical Functionality

- [ ] When input matches the spec, the module returns the expected output.
- [ ] When input is missing, invalid, or out of bounds, the module returns a clear error.
- [ ] The module does not access other modules' private implementations.
- [ ] The module's external API maintains backward compatibility unless the spec explicitly states a breaking change.

## Boundary Conditions

- [ ] Empty input, minimum input, and maximum input behaviors are well-defined.
- [ ] Repeated or concurrent calls do not break state consistency.
- [ ] External dependency failures have traceable error paths.

## Verification Requirements

- [ ] Prioritize running tests directly related to this module.
- [ ] When no related tests exist, perform the minimum viable build, type check, or manual verification.
- [ ] The final report lists verified items, unverified items, and blocking reasons.
