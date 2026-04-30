# Search

## When to use
- Free-text query against a corpus (docs, products, users, code)
- Users know roughly what they want but not its exact location

## When NOT to use
- Pick from a known small list → [select-dropdown.md](select-dropdown.md)
- Filter an already-visible list → use a filter pattern, not a search input
- Single-step lookup with structured input → form fields

## Anatomy
1. Search input with magnifier icon (left)
2. Placeholder hinting what's searchable
3. Clear button (right, when query has content)
4. Optional: scoped-search pill ("In: this project")
5. Optional: keyboard shortcut hint (`⌘K`)
6. Results panel below or popover
7. Optional: recent searches when input is focused but empty
8. Empty / loading / no-results states

## Required states
- default (empty)
- focused (with recent searches)
- typing (debounced)
- loading
- with-results
- no-results
- error

## Best practices
1. Magnifier icon on the left, clear (×) on the right when query non-empty (N4)
2. Placeholder describes what's searchable: "Search projects, docs, people" (N6)
3. Show recent searches when focused with empty query (N7)
4. Debounce queries to ~250 ms (perf) — don't fire on every keystroke
5. Show loading skeleton, never a blank panel (N1)
6. No-results: explain WHY and SUGGEST a fix ("No results for 'foo'. Try fewer words or check spelling.") (N9)
7. Highlight matched terms in results (N1)
8. Keyboard navigation: arrow keys through results, Enter to select, Esc to close (A3)
9. Show keyboard shortcut to open search (`⌘K` / `Ctrl K`) — convention in productivity tools (N7)
10. Mobile: search opens a full-screen view with cancel button — better than a tiny input (D1, F1)

## Common mistakes
- No clear button → user has to manually delete the query
- Results appear in same panel even on partial query "a" → noisy. Wait for ≥ 2 chars.
- Empty results state is just "No results" → unhelpful (N9)
- Auto-submit on every keystroke without debounce → server hammered, UI flickers
- Results panel obscures the input on mobile → keyboard pushes it off screen
- Search inside dropdowns with 8 options → unnecessary; just show the list (N8)

## Device variants
- **mobile-web/native**: tap search opens full-screen; cancel button replaces nav
- **desktop**: inline input with popover results; `⌘K` global shortcut

## Skeleton

```html
<!-- Inline desktop search -->
<div style="position:relative;max-width:480px">
  <span style="position:absolute;left:.75rem;top:50%;transform:translateY(-50%)" aria-hidden="true">🔍</span>
  <input type="search" class="mock-input" placeholder="Search projects, docs, people"
         style="padding-left:2.25rem;padding-right:5rem" aria-label="Search">
  <span class="mock-pill" style="position:absolute;right:2.25rem;top:50%;transform:translateY(-50%)">⌘K</span>
  <button class="mock-button" aria-label="Clear search"
          style="position:absolute;right:.25rem;top:50%;transform:translateY(-50%)">×</button>
</div>

<!-- Results popover -->
<div class="mock-card" style="max-width:480px;margin-top:.5rem" role="listbox">
  <div class="mock-label">Recent</div>
  <div role="option" class="wf-row" style="padding:.5rem 0;cursor:pointer"><span>📄</span><span>Q3 OKRs</span></div>
  <div role="option" class="wf-row" style="padding:.5rem 0;cursor:pointer"><span>👤</span><span>Sarah Kim</span></div>
  <hr class="mock-divider">
  <div class="mock-label">Results for "ren"</div>
  <div role="option" class="wf-row" style="padding:.5rem 0;background:var(--wf-surface-2);cursor:pointer">
    <span>📄</span>
    <span>Q3 <strong>Ren</strong>ewal Plan</span>
  </div>
</div>
```
