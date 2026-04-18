---
name: simulate-spec
description: Pressure-test a spec against realistic and adversarial scenarios before implementation — scenario trace, artifact fitness critique, interface cross-reference, targeted pseudocode. Optional validator between /spec and /plan in the requirements -> spec -> plan pipeline. Use when the user says "simulate the design", "validate this spec", "will this design actually work", "check for gaps in the design", or has a spec ready for end-to-end scrutiny before implementation.
user-invocable: true
argument-hint: "<path-to-spec-doc>"
---

# Spec Simulation Generator

Pressure-test a technical spec by walking realistic and adversarial scenarios through it, critiquing each artifact for fitness, cross-referencing interface and core, and producing a standalone simulation doc whose Gap Register drives coordinated spec patches. The output is both a quality gate and a durable "why we believe this design works" artifact.

This is an OPTIONAL VALIDATOR in the pipeline — runs between `/spec` and `/plan`:

```
/requirements  →  [/msf, /creativity]  →  /spec  →  [/simulate-spec]  →  /plan  →  /execute  →  /verify
                   optional enhancers              (this skill)
                                                  optional validator
```

**Announce at start:** "Using the simulate-spec skill to pressure-test the design."

## Platform Adaptation

These instructions use Claude Code tool names. In other environments:
- **No `AskUserQuestion`:** State your assumption, document it in the output, and proceed. The user reviews after completion.
- **No subagents:** Perform research and analysis sequentially as a single agent.
- **No Playwright MCP:** Note browser-based verification as a manual step for the user.

## Track Progress

This skill has multiple phases. Create one task per phase using your agent's task-tracking tool (e.g., `TodoWrite` in Claude Code, equivalent in other agents). Mark each task in-progress when you start it and completed as soon as it finishes — do not batch completions.

## Load Learnings

Read `~/.pmos/learnings.md` if it exists. Note any entries under `## /simulate-spec` and factor them into your approach for this session.

## Locate Spec

Follow `../.shared/resolve-input.md` with `phase=specs`, `label="spec"`. Read the resolved file end-to-end before Phase 1.

---

## Phase 0: Load Workstream Context

Stub — to be filled in T2.

## Phase 1: Intake, Tier Detection & Scope Declaration

Stub — to be filled in T2.

## Phase 2: Scenario Enumeration

Stub — to be filled in T3.

## Phase 3: Scenario Trace

Stub — to be filled in T4.

## Phase 4: Artifact Fitness Critique

Stub — to be filled in T4.

## Phase 5: Interface ↔ Core Cross-Reference

Stub — to be filled in T4.

## Phase 6: Targeted Pseudocode

Stub — to be filled in T5.

## Phase 7: Gap Resolution

Stub — to be filled in T5.

## Phase 8: Write Simulation Doc

Stub — to be filled in T6.

## Phase 9: Review Loop

Stub — to be filled in T6.

## Phase 10: Workstream Enrichment

Stub — to be filled in T7.

## Phase 11: Capture Learnings

Stub — to be filled in T7.

---

## Anti-Patterns (DO NOT)

To be filled in T7.
