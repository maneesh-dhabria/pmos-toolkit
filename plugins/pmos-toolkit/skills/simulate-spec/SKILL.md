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

Before any other work, follow the context loading instructions in `product-context/context-loading.md` (relative to the skills directory). This determines `{docs_path}` and loads workstream context if available. Use workstream context to inform critique — product constraints and tech-stack decisions shape what counts as a gap. Also note any entries under `## /simulate-spec` in `~/.pmos/learnings.md` and factor them into your approach for this session.

---

## Phase 1: Intake, Tier Detection & Scope Declaration

### 1.1 Locate the spec
Follow `../.shared/resolve-input.md` with `phase=specs`, `label="spec"`. Echo the resolved path before proceeding.

### 1.2 Read the spec end-to-end
Read the full file. Summarize back to the user in 3-5 bullets covering: problem, primary goals, tier, decisions already made. Confirm understanding via AskUserQuestion (or state assumption per Platform Adaptation if AskUserQuestion is unavailable).

### 1.3 Check for existing simulation
Look in `{docs_path}/simulations/` for an existing file covering this feature.
- **If found:** ask "Is this an update to the existing simulation, or a fresh start?" Update mode re-traces only against changed spec sections; fresh start re-runs all phases.
- **If not found:** proceed.

### 1.4 Detect tier from spec header

| Tier | Behavior |
|------|----------|
| **Tier 1** (bug fix) | Skill refuses to run. Announce: "This is a Tier 1 spec — simulation is overkill. Skipping." Then exit. |
| **Tier 2** (enhancement) | All phases run. Inline gap resolution (one gap at a time in Phase 7). 1 review loop. |
| **Tier 3** (feature / new system) | All phases run. Batched gap resolution (by category in Phase 7). 1 review loop. Deeper adversarial coverage in Phase 2. |

The tier is declared in the spec header (e.g., `**Tier:** 2`). If absent, infer from scope (single bug → Tier 1; behavior enhancement → Tier 2; new capability or major redesign → Tier 3) and announce the inferred tier for confirmation.

### 1.5 Scope Declaration

Auto-detect the layers present in the spec by scanning section headers (DB Schema, API Contracts, Frontend Design, CLI, Events, Infrastructure, etc.). Combine with the spec's Non-Goals section. Then ask the user via AskUserQuestion:

> "Scope check:
> - **In this spec:** [auto-detected layers]
> - **Out of scope** (deferred to separate spec or later phase)?
> - **Companion specs** (e.g., backend-spec.md and frontend-spec.md)? Paths if any.
> - **Downstream consumers we should anticipate** (e.g., 'web UI in Phase 2')?"

Record the answers. The scope drives everything downstream:
- **Out-of-scope layers** → their critique buckets in Phase 4 are SKIPPED, not flagged as gaps
- **Companion specs** → cross-referenced during Phase 5 wire-up (read the companion, do the cross-reference table against it)
- **Anticipated consumers** → produce **forward-compat notes** rather than gaps — soft flags like "API response lacks `discount_breakdown` — fine today but likely needed when the visual UI lands"

### 1.6 Record scope

Hold scope state in memory; it gets written into Phase 8's simulation doc Section 1 (Scope).

**Gate:** Do not proceed to Phase 2 until tier is confirmed and scope is declared.

## Phase 2: Scenario Enumeration

Generate the full scenario list in four passes, then confirm with the user before tracing. The point of simulation is to find gaps the spec MISSED — trusting only the spec's stated scenarios defeats the purpose.

### 2a. Extract from spec
Each User Journey and each Edge Case in the spec becomes a numbered scenario (S1, S2, ...). Keep the spec's wording where possible.

### 2b. Generate missing happy-path variants
Look for variants the spec didn't enumerate:
- Different personas (first-time user, power user, admin, support agent)
- Different entry points (deep link, mobile, API direct, CLI)
- Different starting states (empty data, near-quota, post-error recovery)

Add each as a new numbered scenario.

### 2c. Adversarial checklist
For each of these 10 categories, name 1-3 concrete scenarios where applicable to this spec. SKIP categories that don't apply — but state which you skipped and why.

1. **Service/dependency down** — what if a downstream service is unreachable mid-flow?
2. **Concurrent writes** — same resource by same user; same resource by two users; rapid retries
3. **Partial failures** — step N of M fails; some side effects committed, others not
4. **Retries & idempotency** — retry fires after the original eventually succeeded; double-submit
5. **Stale data / cache invalidation** — user sees old data; cache TTL boundary; stale read after write
6. **Permission/auth edge cases** — token expires mid-flow; role downgraded mid-flow; cross-tenant access attempt
7. **Data size / pagination limits** — empty result; result at boundary (page size − 1, page size, page size + 1); 10x expected size
8. **Network partition / timeout** — request sent but response lost; long-running operation timeout
9. **Ordering** — out-of-order event delivery; late-arriving data; clock skew between services
10. **Empty / null / malformed inputs** — required field missing; whitespace-only; UTF-8 edge characters; max-length boundary

### 2d. Model-driven pass
Read the spec critically — what could break that's specific to THIS design and not captured above? Name 3-5 design-specific failure modes. Examples of the shape of question to ask:
- "What if the deduplication window is shorter than the retry window?"
- "What if the spec's batch-size assumption breaks at scale?"
- "What if two flows that share a state column get into a race?"

### Consolidated scenario list

Present the full list as a table:

| # | Scenario | Source | Category |
|---|----------|--------|----------|
| S1 | Customer places order with valid promo | Spec §5.2 | happy |
| S14 | Two customers apply last-remaining promo simultaneously | Adversarial | concurrency |
| S22 | Webhook retry fires after the original succeeded | Adversarial | retry |
| S27 | Promo expires while order is still in cart (5+ min) | Model-driven | timing |

**Source values:** `Spec §X.Y`, `Variant`, `Adversarial`, `Model-driven`.
**Category values:** `happy`, `edge`, `concurrency`, `failure`, `retry`, `timing`, `auth`, `boundary`, `ordering`, `input` (or other category names that fit).

**Gate:** Present consolidated scenario list. Ask "Here are N scenarios. Any missing? Any to remove?" Wait for user confirmation (or stated assumption per Platform Adaptation) before Phase 3.

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
