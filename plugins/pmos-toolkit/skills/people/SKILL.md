---
name: people
description: Shared person/contact directory for the pmos-toolkit. Stores handle, name, designation, role, working relationship, team, email, workstreams, aliases at ~/.pmos/people/. Consumed by /mytasks (and future people-aware skills). Use when the user says "add a person", "find someone", "who is X", "list people", or "/people".
user-invocable: true
argument-hint: "[ | add <name> | list [filters] | show <handle-or-name> | find <text> | set <handle> <field>=<value> | refine <handle> | rebuild-index]"
---

# People

A shared person/contact directory. Toolkit-wide entity store at `~/.pmos/people/`. Consumed by `/mytasks` (and future people-aware skills — 1:1 notes, meeting prep, stakeholder tracking).

**Announce at start:** "Using the people skill to {list|add|find|show|...}."

## Platform Adaptation

These instructions use Claude Code tool names. In other environments:
- **No `AskUserQuestion`:** follow `_shared/interactive-prompts.md` fallback path — one question at a time as plain text with numbered responses.
- **No subagents:** sequential single-agent operation.

## References

- `schema.md` — record file shape, enum values, `INDEX.md` format
- `lookup.md` — fuzzy-match algorithm, handle derivation rules
- `_shared/interactive-prompts.md` — interactive prompting protocol

---

## Phase 0: Subcommand Routing

Parse the user's argument to determine the subcommand.

| Argument shape | Subcommand |
|---|---|
| empty | Phase 1 (show INDEX.md) |
| `add <name>` | Phase 3 (proactive create — interactive) |
| `list [flags]` | Phase 5 (filtered list) |
| `show <handle-or-name>` | Phase 4 (render record) |
| `find <text>` | Phase 2 (fuzzy-match lookup) |
| `set <handle> <field>=<value>` | Phase 6 (single-field edit) |
| `refine <handle>` | Phase 7 (interactive multi-field refine) |
| `rebuild-index` | Phase 8 (regenerate INDEX.md) |

Unknown verbs error: `Unknown subcommand '{verb}'. Run /people for the default list, or see argument hint for valid forms.`

---

## Phase 1: Show INDEX

Triggered by `/people` with no arguments.

### Step 1: Resolve `~/.pmos/people/`

If `~/.pmos/people/INDEX.md` does not exist (or `~/.pmos/people/` is missing entirely), output:

`No people yet. Add a person with /people add <name>.`

Then exit.

### Step 2: Validate freshness

Compare `INDEX.md`'s `Last regenerated:` date against the most recent mtime of any `~/.pmos/people/*.md` (excluding `INDEX.md` itself). If any record is more recent, regenerate INDEX.md (apply Phase 8) before rendering.

### Step 3: Render

Output the contents of `~/.pmos/people/INDEX.md` to the user.

---

## Phase 8: Rebuild Index

Triggered by `/people rebuild-index`. Also invoked internally by Phases 3, 6, 7 after any write.

### Step 1: Read records

Glob `~/.pmos/people/*.md` (excluding `INDEX.md`). For each, parse frontmatter. Skip files with malformed frontmatter (emit a one-line warning per skip; do not abort).

### Step 2: Sort

Sort by `name` ascending (case-insensitive).

### Step 3: Write INDEX.md

Overwrite `~/.pmos/people/INDEX.md` with the format defined in `schema.md` (### INDEX.md format section):

```markdown
# People

Last regenerated: {today ISO date}

| handle | name | designation | role | working_relationship | team | email |
|--------|------|-------------|------|----------------------|------|-------|
| {handle} | {name} | {designation or empty} | {role or empty} | {working_relationship or empty} | {team or empty} | {email or empty} |
```

Empty optional fields render as empty cells (no `null`, no dashes).

### Step 4: Report

If invoked directly (Phase 8 entered as `rebuild-index`): `Regenerated INDEX.md: {count} people.`
If invoked from another phase: silent on success, warn on failure.

---

## Phase 2: Fuzzy-Match Find

Triggered by `/people find <text>`. Read-only lookup. Used by `/mytasks` capture and by users directly.

Algorithm and tier definitions: see `lookup.md`.

### Step 1: Resolve and read

If `~/.pmos/people/` does not exist or contains no records, output: `No people in directory. Add one with /people add <name>.` Exit.

Otherwise, glob `~/.pmos/people/*.md` (excluding `INDEX.md`). Parse frontmatter for each. Skip malformed files with a one-line warning.

### Step 2: Match in priority order

Apply the 5-tier match algorithm from `lookup.md`. Stop at the first tier that produces matches; do not collect from lower tiers if a higher tier hit.

For each record, evaluate match tiers in order:
1. Exact handle (case-insensitive on `handle:`).
2. Exact alias (case-insensitive on any entry in `aliases:`).
3. Exact name (case-insensitive on `name:`).
4. Substring on handle / name / aliases.
5. Initials of `name:` (only if input length ≤ 3 AND input is all letters).

Within the matching tier, sort by `updated:` desc; break ties alphabetically by handle.

### Step 3: Render

- **0 matches:** `No matches for '{input}'.`
- **1 match:** `1 match: {handle} ({name}){match-note}.`
  - `{match-note}` is empty for tier 1, ` — matched alias '{alias}'` for tier 2, omitted for tier 3, ` — substring match` for tier 4, ` — initials match` for tier 5.
- **N matches:**
  ```
  {N} matches:
    {handle} ({name}){match-note}
    ...
  ```

### Step 4: Caller integration

When `find` is invoked programmatically by `/mytasks` (not a user-typed command), the caller reads the rendered output and parses out handles. The output format above is contract — do not change without updating callers.

---

(Phases 3, 4, 5, 6, 7 are added in subsequent tasks.)
