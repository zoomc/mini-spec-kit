## Coding Principles

> Derived from Andrej Karpathy's LLM coding guidelines. These apply during **every** Implement phase.

**1. Think Before Coding**
- State assumptions explicitly before writing code. If uncertain, stop and ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.

**2. Simplicity First**
- Write minimum code that solves the problem. Nothing speculative.
- No features beyond what was asked. No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

**3. Surgical Changes**
- Touch only what the plan specifies. Do not refactor adjacent code.
- Match existing style, even if you'd do it differently.
- When your changes create orphans (unused imports/vars), clean up only YOUR orphans.
- Test: Every changed line should trace directly to the user's request.

**4. Goal-Driven Execution**
- Transform tasks into verifiable goals before coding.
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- For multi-step tasks, state a brief plan with verify steps before implementing.
