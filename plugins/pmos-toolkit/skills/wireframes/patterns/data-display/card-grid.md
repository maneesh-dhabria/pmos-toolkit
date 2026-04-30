# Card Grid

## When to use
- Visual browsing of peer items (products, projects, templates, articles)
- Visual content matters (thumbnail, image, preview)
- 2-D scanning expected (rows AND columns)

## When NOT to use
- Pure text data → [table.md](table.md) or [list.md](list.md)
- Sequential content → list
- Sparse content (< 6 items) → list or sentences

## Anatomy
1. Grid container (responsive columns)
2. Cards: thumbnail/preview + title + 1–2 metadata lines + optional action
3. Optional: filter/sort bar above
4. Optional: pagination or "Load more" below
5. Required: empty state

## Required states
- default
- with-filter-applied
- empty
- loading (skeleton cards)
- error
- card-hovered (lift + shadow)
- card-selected (in a picker context)

## Best practices
1. Equal-height cards within a row (G2) — uneven heights look broken
2. Image/thumbnail at the top, fixed aspect ratio (G2)
3. 3–4 columns desktop, 2 mobile, 1 narrow mobile (G4)
4. Hover state: shadow lift + cursor change → signals interactive (N1)
5. Whole card is the tap target, not just the title (F1)
6. Title truncates with ellipsis at 2 lines max (G3)
7. Loading: skeleton cards in the same shape as real ones (N1)
8. Empty state offers a CTA to add the first item (N9)
9. Cards have visible boundary OR clear spacing — never both heavy borders AND shadows (N8)

## Common mistakes
- Variable card heights → ragged grid looks broken (G2)
- Image-less cards in a card grid → use a list instead (G2)
- Tiny click targets (just the title) → fails Fitts (F1)
- 6+ columns desktop → cards too small, content cramped (G4)
- Skeleton state in a totally different shape than real cards → jarring transition (N4)

## Device variants
- **desktop-web/-app**: 3–4 columns
- **mobile-web**: 2 columns; 1 column for content-heavy cards
- **native**: similar to mobile-web; respect safe-area insets

## Skeleton

```html
<div class="wf-row" style="justify-content:space-between;margin-bottom:1rem">
  <h2 style="font-size:18px">Templates</h2>
  <input type="search" class="mock-input" placeholder="Filter templates…" style="max-width:240px">
</div>

<div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:1rem">
  <article class="mock-card" style="cursor:pointer">
    <div class="mock-img" style="aspect-ratio:16/10;margin-bottom:.75rem"></div>
    <div style="font-weight:600">Sales pipeline</div>
    <div class="wf-muted" style="font-size:13px">5 stages · 12 fields</div>
  </article>
  <article class="mock-card" style="cursor:pointer">
    <div class="mock-img" style="aspect-ratio:16/10;margin-bottom:.75rem"></div>
    <div style="font-weight:600">Customer onboarding</div>
    <div class="wf-muted" style="font-size:13px">4 stages · 8 fields</div>
  </article>
  <!-- skeleton card example -->
  <article class="mock-card">
    <div class="skeleton" style="aspect-ratio:16/10;margin-bottom:.75rem;height:auto"></div>
    <div class="skeleton skeleton--lg" style="width:70%;margin-bottom:.5rem"></div>
    <div class="skeleton" style="width:50%"></div>
  </article>
</div>
```
