---
name: backlog
description: Maintain a lightweight, AI-readable backlog of features, bugs, tech-debt, and ideas inside the repo. Zero-friction quick-capture (`/backlog add ...`) plus structured tracking with status, priority, and acceptance criteria. Integrates with the requirements -> spec -> plan -> execute -> verify pipeline via explicit `--backlog <id>` linkage. Use when the user says "add to backlog", "capture this idea", "track this bug", "show the backlog", "promote a backlog item", or "what's in the backlog".
user-invocable: true
argument-hint: "[<text> | add <text> | list [filters] | show <id> | refine <id> | set <id> <field>=<value> | promote <id> | link <id> <doc> | archive | rebuild-index]"
---

# Backlog

A repo-resident, AI-readable backlog. Two jobs: (1) zero-friction capture buffer for ideas/bugs/deferred-work that surface mid-flow, (2) lightweight tracker with status, priority, and pipeline linkage.

```
                                    ┌─ deferred items ──┐
/backlog (capture)                  ↓                   │
       │                                                │
       ▼                                                │
   inbox -> ready -> /backlog promote -> /requirements -> /spec -> /plan -> /execute -> /verify
                                          (or /spec)         │        │        │          │
                                                             ↓        ↓        ↓          ↓
                                                          spec'd  planned  in-progress  done
```

**Announce at start:** "Using the backlog skill to {capture|list|refine|...}."

## Platform Adaptation

These instructions use Claude Code tool names. In other environments:
- **No `AskUserQuestion`:** State your assumption, document it in the output, and proceed. The user reviews after completion.
- **No subagents:** Perform research and analysis sequentially as a single agent.

## References

- `schema.md` — item file shape, enum values, `INDEX.md` format
- `inference-heuristics.md` — keyword → type table for quick-capture
- `pipeline-bridge.md` — how `--backlog <id>` integrates with pipeline skills

---

## Phase 0: Subcommand Routing

Parse the user's argument to determine the subcommand. Be liberal with the form — both `/backlog add foo` and `/backlog "foo"` work for capture.

| Argument shape | Subcommand |
|---|---|
| empty | Phase 1 (show local INDEX.md) |
| `add <text>` or any free text not matching another verb | Phase 2 (quick-capture) |
| `list [flags]` | Phase 3 (filtered list) |
| `show <id>` | Phase 4 (render item) |
| `refine <id>` | Phase 5 (interactive refine) |
| `set <id> <field>=<value>` | Phase 6 (single-field edit) |
| `promote <id>` | Phase 7 (hand off to pipeline) |
| `link <id> <doc-or-pr>` | Phase 8 (manual linkage) |
| `archive [--quarter Q]` | Phase 9 (archive done/wontfix) |
| `rebuild-index` | Phase 10 (regenerate INDEX.md) |

If the first token is not a recognized verb AND the argument is non-empty, treat the whole argument as `add <text>` (frictionless capture is the priority).

---

[Subsequent phases will be added in later tasks]
