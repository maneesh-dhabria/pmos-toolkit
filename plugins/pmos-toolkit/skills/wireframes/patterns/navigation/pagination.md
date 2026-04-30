# Pagination

## When to use
- Bounded result sets (you know the total count)
- Users may want to jump to specific pages
- Tables, search results, archives

## When NOT to use
- Continuous feeds (social, news) → infinite scroll or "Load more" button
- Sets ≤ 20 items → show all, no pagination needed
- Real-time data that changes between page loads

## Anatomy
1. Previous / Next buttons
2. Page numbers (with current highlighted)
3. First / Last shortcuts (for sets > 10 pages)
4. Total count or page-X-of-Y indicator
5. Optional: page-size selector ("Rows per page: 25")

## Required states
- default (mid-set)
- first-page (Prev disabled)
- last-page (Next disabled)
- single-page (controls hidden or disabled)
- with-jump (input field for go-to-page on huge sets)

## Best practices
1. Always show "X of Y" or total count (N1) — users orient by knowing the size
2. Disabled buttons stay visible but with reduced contrast (A2) — don't hide
3. Show 5–7 page-number buttons + ellipsis: `1 … 4 5 [6] 7 8 … 42` (F2)
4. Make Prev/Next labels explicit ("Previous", "Next") not just arrows (N6, A4)
5. Page-size selector defaults to 25 or 50 — most users never change it (N7)
6. Persist page-size choice across sessions (N7)
7. Use real `<a>` with URL params, not just JS — supports bookmarking and back button (N3, A1)
8. Touch targets ≥ 44×44 on mobile (F1, A5)

## Common mistakes
- Only Prev/Next with no page count → users can't gauge progress through results (N1)
- "Load more" button on a paginated set → mixes patterns; pick one
- Hidden disabled state (button vanishes) → layout shifts, confusing (N4)
- Page numbers that don't update the URL → no bookmarking, broken back button
- Tiny arrow targets on mobile → fails Fitts (F1)

## Device variants
- **desktop-web/-app**: full numbered pagination
- **mobile-web**: simplified to Prev / Page X of Y / Next
- **native**: prefer pull-to-refresh + infinite scroll for feeds; pagination unusual

## Skeleton

```html
<nav class="wf-row" aria-label="Pagination" style="justify-content:space-between">
  <span class="wf-muted">Showing 51–75 of 247</span>
  <div class="wf-row">
    <button class="mock-button" aria-label="Previous page">‹ Previous</button>
    <button class="mock-button">1</button>
    <span class="wf-muted">…</span>
    <button class="mock-button">2</button>
    <button class="mock-button mock-button--primary" aria-current="page">3</button>
    <button class="mock-button">4</button>
    <span class="wf-muted">…</span>
    <button class="mock-button">10</button>
    <button class="mock-button" aria-label="Next page">Next ›</button>
  </div>
  <label class="wf-row" style="gap:.5rem">
    <span class="wf-muted">Rows per page</span>
    <select class="mock-input" style="width:auto"><option>25</option><option>50</option><option>100</option></select>
  </label>
</nav>
```
