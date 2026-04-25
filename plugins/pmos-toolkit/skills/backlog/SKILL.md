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

## Phase 1: Show Local INDEX

Triggered by `/backlog` with no arguments.

### Step 1: Resolve `backlog/`

If `<repo>/backlog/INDEX.md` does not exist (or `<repo>/backlog/` is missing entirely), output:

`No backlog yet. Capture an item with /backlog add <text>.`

Then exit.

### Step 2: Validate freshness

Compare `backlog/INDEX.md`'s "Last regenerated:" date against `git log -1 --format=%cI -- backlog/items/`. If items have been modified more recently than INDEX, regenerate (apply Phase 10) before rendering.

### Step 3: Render

Output the contents of `backlog/INDEX.md` to the user.

---

## Phase 2: Quick-Capture (`add` or bare text)

Triggered by `/backlog add <text>` OR `/backlog <any free text>` (no recognized verb).

**This phase MUST complete in a single tool-call sequence with NO clarifying questions.** Wrong inference is acceptable; capture friction is not.

### Step 1: Resolve `backlog/` location

- If `<repo>/backlog/items/` exists, use it.
- Else, create `<repo>/backlog/items/` with `mkdir -p`.

(`<repo>` = git repo root, found via `git rev-parse --show-toplevel`. If not in a git repo, use the current working directory.)

### Step 2: Allocate id

Scan `backlog/items/` and `backlog/archive/**/` for filenames matching `^([0-9]{4})-`. Take the max numeric prefix; allocate `id = max + 1`. If neither directory exists or is empty, `id = 1`. Format as 4-digit zero-padded.

### Step 3: Infer type

Apply `inference-heuristics.md` to `<text>` (case-insensitive, first-match-by-order). If no keyword matches, set `type: idea` and remember to emit the fallback notice in Step 6.

### Step 4: Build slug

- Lowercase the title.
- Replace any run of non-alphanumeric chars with a single hyphen.
- Trim leading/trailing hyphens.
- Truncate to 60 characters at a hyphen boundary if possible, otherwise hard-truncate.

### Step 5: Write the item file

Path: `backlog/items/{id}-{slug}.md`

Content (frontmatter only, no body):

```yaml
---
id: {id}
title: {original text, unchanged}
type: {inferred type}
status: inbox
priority: should
labels: []
created: {today YYYY-MM-DD}
updated: {today YYYY-MM-DD}
source:
spec_doc:
plan_doc:
pr:
parent:
dependencies: []
---
```

### Step 6: Regenerate `INDEX.md`

Apply Phase 10 (rebuild-index) inline. If regeneration fails, the item file is still written — emit a warning suggesting `/backlog rebuild-index`, but DO NOT roll back the item write.

### Step 7: Report

Output exactly one line:

`Captured #{id} ({type}, should): "{title}"`

If `type` was the fallback (`idea` from rule 4 of `inference-heuristics.md`), append:

` — type inferred as 'idea' (no strong signal); use /backlog set {id} type=... to correct.`

---

## Phase 3: Filtered List

Triggered by `/backlog list [flags]`.

Recognized flags (all optional, all combinable; AND semantics):

| Flag | Effect |
|---|---|
| `--type <feature\|bug\|tech-debt\|idea>` | Filter by type |
| `--status <inbox\|ready\|spec'd\|planned\|in-progress\|done\|wontfix>` | Filter by status |
| `--priority <must\|should\|could\|maybe>` | Filter by priority |
| `--label <name>` | Item must include this label |
| `--repo <name>` | (Workstream mode only) restrict to one linked repo |
| `--workstream` | Aggregate across all repos linked to the active workstream |
| `--include-archive` | Include items in `backlog/archive/**/` |

### Step 1: Resolve scope

- Without `--workstream`: read items from `<repo>/backlog/items/` (and `archive/**/` if `--include-archive`).
- With `--workstream`: apply the workstream aggregator from Phase 11.

### Step 2: Validate flag values against enums

Reject unknown flag values with the allowed list. Example: `Unknown status 'open'. Allowed: inbox, ready, spec'd, planned, in-progress, done, wontfix.`

### Step 3: Apply filters and sort

Sort: priority bucket (must > should > could > maybe) → score desc (nulls last) → updated desc.

### Step 4: Render

Render a markdown table identical in shape to a single section of `INDEX.md`, but with no priority grouping (sorted flat list). Columns: `id | type | status | priority | title | spec | plan | pr`. In `--workstream` mode, prepend a `repo` column.

If zero matches: `No items match.`

---

## Phase 4: Show Item

Triggered by `/backlog show <id>`.

### Step 1: Normalize id

Accept `42`, `0042`, or `repo-name#0042` (workstream form). For local form, zero-pad to 4 digits.

### Step 2: Locate the file

Search `<repo>/backlog/items/{id}-*.md`. If not found, search `<repo>/backlog/archive/**/{id}-*.md`.

### Step 3: Handle missing

If still not found:

1. Find existing items whose id starts with the same digit prefix.
2. Output: `No item with id {id}. Closest matches by prefix: {list or "(none)"}. Run /backlog list to see all items.`

### Step 4: Render

Output the file contents verbatim, fenced as markdown.

---

## Phase 10: Rebuild Index

Triggered by `/backlog rebuild-index`. Also invoked internally by Phases 2, 5, 6, 7, 8, 9 after any item write.

### Step 1: Read items

Glob `<repo>/backlog/items/*.md`. For each, parse frontmatter. Skip files with malformed frontmatter (emit one-line warning per skip; do not abort).

### Step 2: Group and sort

Group by `priority`. Within each group, sort by `score` desc (nulls last), then `updated` desc.

### Step 3: Write `INDEX.md`

Overwrite `<repo>/backlog/INDEX.md` with the format defined in `schema.md` (### INDEX.md format section). Include `Last regenerated: {today}` after the title.

### Step 4: Report

If invoked directly: `Regenerated INDEX.md: {count} items.`
If invoked from another phase: silent on success, warn on failure.
