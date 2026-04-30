# Table

## When to use
- Comparable rows with multiple attributes (≥ 3 columns)
- Sorting, filtering, scanning across rows
- Tabular data: spreadsheets, transactions, lists of records with metadata

## When NOT to use
- 1–2 attributes per row → [list.md](list.md)
- Visual browsing → [card-grid.md](card-grid.md)
- Single-record details → [detail-view.md](detail-view.md)
- Mobile-only feature with > 3 columns → tables don't fit; convert to cards

## Anatomy
1. Table header row (column titles, sortable indicators)
2. Body rows
3. Optional: row selection checkbox column
4. Optional: row actions column (right-aligned, three-dot menu)
5. Optional: filter / search bar above
6. Optional: bulk-action bar appears when rows selected
7. Optional: footer with [pagination.md](../navigation/pagination.md) or totals
8. Required: empty state, loading state

## Required states
- default (with rows)
- empty (no data)
- loading
- error
- with-rows-selected (bulk-action bar visible)
- with-sorted-column (sort indicator on a column)
- with-filtered-data (filter applied)
- row-hovered

## Best practices
1. Right-align numeric columns; left-align text (G3, N4) — easier to scan
2. Sortable columns indicate with arrow icons (N1) — non-sortable have no icon
3. Sticky header on scroll for tables > 1 viewport (N6)
4. Zebra striping or 1px row dividers — pick one, never both (G2, N8)
5. Row actions in a `⋯` menu, not 5 inline buttons (F2, N8)
6. Selection: checkbox column on left; "Select all" in header (A4)
7. Bulk-action bar appears at top and shows count: "3 rows selected" + actions (N1)
8. Empty state explains and offers an action (N9)
9. Mobile: convert each row to a card stacking attributes (D1) — never horizontal scroll for primary tables
10. Use `<table>` semantically; never `<div>`s pretending to be a table (A1)

## Common mistakes
- 12 columns crammed → unscannable. Cut to essentials, hide extras behind row click (F2)
- All columns same width → scannability suffers (G3)
- No sort indicators on sortable columns → users don't know they can sort
- Inline buttons per row eat horizontal space → use overflow menu (N8)
- "No data" empty state with no CTA (N9, see [empty-state.md](../feedback/empty-state.md))
- Horizontal scroll on mobile → users miss content beyond fold (D1)

## Device variants
- **desktop-web/-app**: full table
- **mobile-web**: convert rows to stacked cards; show 2–3 most important attributes
- **native**: list-view with disclosure indicator → tap to detail

## Skeleton

```html
<!-- Filter bar -->
<div class="wf-row" style="justify-content:space-between;margin-bottom:.75rem">
  <input type="search" class="mock-input" placeholder="Filter rows…" style="max-width:280px">
  <button class="mock-button mock-button--primary">+ New deal</button>
</div>

<table style="width:100%;border-collapse:collapse;font-size:14px">
  <thead style="border-bottom:1px solid var(--wf-border-2)">
    <tr>
      <th style="text-align:left;padding:.5rem;width:32px">
        <input type="checkbox" aria-label="Select all">
      </th>
      <th style="text-align:left;padding:.5rem"><button class="wf-mono">Deal ▲</button></th>
      <th style="text-align:left;padding:.5rem">Stage</th>
      <th style="text-align:right;padding:.5rem">Value</th>
      <th style="text-align:left;padding:.5rem">Owner</th>
      <th style="width:32px"></th>
    </tr>
  </thead>
  <tbody>
    <tr style="border-bottom:1px solid var(--wf-border-2)">
      <td style="padding:.5rem"><input type="checkbox"></td>
      <td style="padding:.5rem">Acme Pilot Q3</td>
      <td style="padding:.5rem"><span class="mock-pill">Negotiation</span></td>
      <td style="padding:.5rem;text-align:right" class="wf-mono">$48,000</td>
      <td style="padding:.5rem">Sarah Kim</td>
      <td style="padding:.5rem"><button class="mock-button" aria-label="Row actions">⋯</button></td>
    </tr>
  </tbody>
</table>

<!-- Empty state replaces tbody -->
<!-- <div class="wf-message"><div class="wf-message__title">No deals yet</div>… </div> -->
```
