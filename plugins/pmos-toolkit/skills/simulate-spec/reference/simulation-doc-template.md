# Simulation Doc Template

Reference template for the artifact produced by Phase 8 of `/simulate-spec`.

```markdown
# <Feature Name> — Design Simulation

**Date:** YYYY-MM-DD
**Spec:** `<path-to-spec>`
**Tier:** 2 | 3

---

## 1. Scope
- **In scope:** [layers covered]
- **Out of scope:** [layers deferred — with pointers if known]
- **Companion specs:** [paths]
- **Downstream consumers anticipated:** [list]

## 2. Scenario Inventory

| # | Scenario | Source | Category |
|---|----------|--------|----------|

## 3. Scenario Coverage Matrix

| Scenario | Step | Spec Artifact | Status |
|----------|------|---------------|--------|

## 4. Artifact Fitness Findings

### 4.1 Data & Storage
### 4.2 Service Interfaces
### 4.3 Behavior (State / Workflows)
### 4.4 Interface (UI / CLI / Library — whichever applies)
### 4.5 Operational (NFRs, Rollout)
### 4.6 Other Artifacts (if present)

## 5. Interface ↔ Core Cross-Reference

| # | Interaction | Trigger | Endpoint/Function | Req Shape Match | Res Has What Consumer Needs | Error Mapping Defined | Notes |

## 6. Targeted Pseudocode

### 6.1 [Flow Name]
[Pseudocode block + DB calls + state transitions + error branches + concurrency notes]

## 7. Gap Register

| # | Gap | Exposed By | Severity | Disposition | Notes |
|---|-----|-----------|----------|-------------|-------|

## 8. Accepted Risks
Gaps the user explicitly chose not to fix, with rationale.

## 9. Open Questions

| # | Question | Owner | Needed By |

## 10. Spec Patches Applied

| # | Section | Change Summary | Gap # |

## 11. Review Log

| Loop | Findings | Changes Made |
```
