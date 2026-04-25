---
name: mytasks
description: Persistent personal task tracker — distinct from Claude Code's session-scoped TaskCreate/TaskList tools. Use for real-world tasks (LNO importance, due dates, people, check-ins, workstream). Lives at ~/.pmos/tasks/. Use when the user says "add a task", "what's on my plate", "tasks for sarah", "what's due this week", "check in on X", "/mytasks", or names a task to capture.
user-invocable: true
argument-hint: "[ | <text> | add <text> | list [filters] | today | week | overdue | waiting | checkins | for <handle> | in <workstream> | show <id> | set <id> <field>=<value> | refine <id> | done <id> [note] | drop <id> [reason] | checkin <id> [note] | archive | rebuild-index]"
---

# My Tasks

A lightweight, file-based personal task tracker. Asana/Todoist-class personal life-OS layer, but local-first, AI-native, and embedded in the `pmos-toolkit` ecosystem.

```
                                       ┌─ default daily view ──┐
/mytasks (capture)                     ↓                       │
       │                                                       │
       ▼                                                       │
   pending → in-progress → completed                           │
       │       │              │                                │
       │       ▼              ▼                                │
       │    waiting        dropped → /mytasks archive (>30d)   │
       └──────────────────────────────────────────────────────┘
```

**Hard isolation from `/backlog`.** No code path in `/mytasks` reads or writes `<repo>/backlog/`. The two skills are independent.

**Tip:** `~/.pmos/` is local by default. If you want version history and cross-machine sync, run `git init ~/.pmos/` and push it to a private remote. The skill never enforces this.

**Announce at start:** "Using the mytasks skill to {capture|list|refine|...}."

## Platform Adaptation

These instructions use Claude Code tool names. In other environments:
- **No `AskUserQuestion`:** follow `_shared/interactive-prompts.md` fallback path — one question at a time as plain text with numbered responses.
- **No subagents:** sequential single-agent operation.

## References

- `schema.md` — item file shape, enum values, `INDEX.md` format
- `inference-heuristics.md` — quick-capture keyword + date + person + workstream parsing rules
- `_shared/interactive-prompts.md` — interactive prompting protocol (used by `add`, `refine`, unknown-person flow)
- Sibling skill `/people` — fuzzy-match person lookup via `/people find`

---

## Phase 0: Subcommand Routing

Parse the user's argument to determine the subcommand. Be liberal with the form — both `/mytasks add foo` and `/mytasks "foo"` work for capture.

| Argument shape | Subcommand |
|---|---|
| empty | Phase 1 (default daily view) |
| `add <text>` | Phase 3 (rich capture — interactive) |
| `list [flags]` | Phase 4 (filtered list) |
| `today` / `week` / `overdue` / `waiting` / `checkins` | Phase 5 (named view) |
| `for <handle>` / `in <workstream>` | Phase 5 (named view) |
| `show <id>` | Phase 6 (render item) |
| `set <id> <field>=<value>` | Phase 7 (single-field edit) |
| `refine <id>` | Phase 8 (interactive multi-field refine) |
| `done <id> [note]` | Phase 9 (status → completed shortcut) |
| `drop <id> [reason]` | Phase 9 (status → dropped shortcut) |
| `checkin <id> [note]` | Phase 10 (check-in mechanics) |
| `archive [--quarter Q]` | Phase 11 (archive completed/dropped) |
| `rebuild-index` | Phase 12 (regenerate INDEX.md) |
| (any other free text not matching a verb) | Phase 2 (quick capture) |

Quick capture (Phase 2) is the fall-through. If the first token is not a recognized verb AND the argument is non-empty, treat the whole argument as `<bare text>` for quick-capture.

---

## Phase 1: Default Daily View

Triggered by `/mytasks` with no arguments.

### Step 1: Resolve `~/.pmos/tasks/`

If `~/.pmos/tasks/INDEX.md` does not exist (or `~/.pmos/tasks/` is missing entirely), output:

`No tasks yet. Capture one with /mytasks <text> or /mytasks add <text>.`

Then exit.

### Step 2: Validate freshness

Compare `INDEX.md`'s `Last regenerated:` date against the most recent mtime of any `~/.pmos/tasks/items/*.md`. If items have been modified more recently, regenerate (apply Phase 12) before rendering.

### Step 3: Render

Output the contents of `~/.pmos/tasks/INDEX.md` to the user. The INDEX is already grouped by importance per `schema.md`, so the rendering is verbatim.

If `INDEX.md` exists but contains zero items (empty groups), output: `No active tasks. Capture one with /mytasks <text>.`

---

## Phase 12: Rebuild Index

Triggered by `/mytasks rebuild-index`. Also invoked internally by Phases 2, 3, 7, 8, 9, 10, 11 after any item write.

### Step 1: Read items

Glob `~/.pmos/tasks/items/*.md`. For each, parse frontmatter. Skip files with malformed frontmatter (emit one-line warning per skip; do not abort).

### Step 2: Filter

Exclude items with `status: completed` or `status: dropped`. They live only in item files; archived items live in `archive/` and are also excluded.

### Step 3: Group and sort

Group by `importance` (buckets: `leverage`, `neutral`, `overhead`). Items with no `importance:` field default to the `neutral` bucket. Within each group, sort by `due` ascending (no-due last) → `updated` descending.

### Step 4: Write INDEX.md

Overwrite `~/.pmos/tasks/INDEX.md` with the format defined in `schema.md`:

```markdown
# My Tasks

Last regenerated: {today}

## leverage
| id | type | status | due | next_checkin | title | workstream |
|----|------|--------|-----|--------------|-------|------------|
{rows or empty if bucket has zero items}

## neutral
| id | type | status | due | next_checkin | title | workstream |
|----|------|--------|-----|--------------|-------|------------|
{rows or empty}

## overhead
| id | type | status | due | next_checkin | title | workstream |
|----|------|--------|-----|--------------|-------|------------|
{rows or empty}
```

If a bucket has zero items, write the `## {bucket}` header and the column row, then an empty data section (no rows). Do NOT omit the bucket entirely.

### Step 5: Report

If invoked directly: `Regenerated INDEX.md: {N active items} ({completed_excluded} completed/dropped excluded).`
If invoked from another phase: silent on success, warn on failure.

---

(Phases 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 are added in subsequent tasks.)
