# Scenario Fixtures

Each section below describes an expected agent behavior given the matching fixture under `tests/fixtures/`. To verify, the implementer reads the relevant SKILL.md phases and walks through each scenario manually.

## Fixture: empty-people

A directory with no records (or a missing `~/.pmos/people/` directory).

### Scenario: `/people` (no args, empty fixture)

Expected:
- Output: `No people yet. Add a person with /people add <name>.`
- No files created.

### Scenario: `/people rebuild-index` (empty fixture)

Expected:
- Glob returns 0 files.
- Write `~/.pmos/people/INDEX.md` with header and empty table (column row only, no data rows).
- Output: `Regenerated INDEX.md: 0 people.`

## Fixture: with-people

Three records: `sarah-chen`, `mark-davis`, `sarah-patel`.

### Scenario: `/people` (no args, with-people fixture)

Expected:
- Read INDEX.md (skip regeneration since INDEX is fresh — `Last regenerated: 2026-04-22` matches the most recent record `updated:`).
- Render the INDEX.md table verbatim.

### Scenario: `/people` (no args, with-people fixture, after manual edit to sarah-chen.md without INDEX update)

Expected:
- Detect freshness drift (sarah-chen.md mtime newer than INDEX.md `Last regenerated:`).
- Regenerate INDEX.md (apply Phase 8).
- Render the regenerated INDEX.md.

### Scenario: `/people rebuild-index` (with-people fixture)

Expected:
- Read all 3 records.
- Sort by name ascending: Mark Davis, Sarah Chen, Sarah Patel.
- Write INDEX.md.
- Output: `Regenerated INDEX.md: 3 people.`

### Scenario: `/people find sarah-chen` (with-people fixture)

Expected (exact handle match, priority 1):
- Return single result: `sarah-chen`.
- Render: `1 match: sarah-chen (Sarah Chen)`.

### Scenario: `/people find sc` (with-people fixture)

Expected (alias match for sarah-chen, priority 2):
- Single result: `sarah-chen`.
- Render: `1 match: sarah-chen (Sarah Chen) — matched alias 'sc'`.

### Scenario: `/people find Sarah Chen` (with-people fixture)

Expected (exact name match, priority 3):
- Single result: `sarah-chen`.

### Scenario: `/people find sarah` (with-people fixture)

Expected (alias match for sarah-chen, priority 2 — beats substring tier):
- Single result: `sarah-chen` (alias `sarah` matches before substring tier fires).
- Render: `1 match: sarah-chen (Sarah Chen) — matched alias 'sarah'`.

### Scenario: `/people find sara` (with-people fixture)

Expected (substring match — `sara` is not an exact alias, so tier 4 fires):
- Two results, both Sarah-named records:
  - sarah-chen (updated 2026-04-22)
  - sarah-patel (updated 2026-04-22)
- Tie on date; alphabetical by handle.
- Render:
  ```
  2 matches:
    sarah-chen (Sarah Chen) — substring match
    sarah-patel (Sarah Patel) — substring match
  ```

### Scenario: `/people find SP` (with-people fixture)

Expected (initials match for Sarah Patel, priority 5; input length 2, all letters):
- Single result: `sarah-patel`.
- Render: `1 match: sarah-patel (Sarah Patel) — initials match`.

### Scenario: `/people find xyz` (with-people fixture)

Expected (no match):
- Render: `No matches for 'xyz'.`
