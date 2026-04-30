# List

## When to use
- Sequential items with **1–3 attributes** each
- Linear scanning expected (not comparison across columns)
- Mobile-first surfaces (lists translate well to cards)

## When NOT to use
- ≥ 4 attributes per item or comparison needed → [table.md](table.md)
- Visual browsing dominant → [card-grid.md](card-grid.md)
- Single item → [detail-view.md](detail-view.md)

## Anatomy
1. List container
2. List items, separated by dividers or spacing
3. Per item: leading icon/avatar (optional), primary label, secondary metadata, trailing affordance (chevron, action button)
4. Optional: section headers grouping items
5. Required: empty state

## Required states
- default
- empty
- loading (skeleton items)
- with-selected-item (in a list+detail layout)
- item-hovered / pressed
- swipe-actions revealed (mobile)

## Best practices
1. Consistent leading element across items (avatar OR icon, not mixed) (G2)
2. Two-line item: primary label bold, secondary metadata muted (G3)
3. Trailing chevron `›` indicates row is tappable into detail (N1)
4. Section headers for grouping; keep groups < 7 items each ideally (G1, F2)
5. Touch target ≥ 44×56 on mobile (whole row tappable, not just text) (F1, A5)
6. Empty state offers a CTA (N9)
7. Use `<ul>` / `<li>` semantically (A1)
8. Action buttons inline with the row text are easy to mis-tap on mobile — prefer swipe or overflow menu (F1)

## Common mistakes
- Mixed leading elements (some rows with avatar, some with icon, some with nothing) → looks broken (G2)
- Centered text → unscannable; lists scan left-edge (G3)
- Tiny tap targets on mobile → frustrating (F1)
- No empty state → blank list looks like a bug (N1, N9)
- Action buttons inline with text → mis-taps (F1)

## Device variants
- **mobile-web/native**: full-row tap target, swipe-to-reveal actions, pull-to-refresh
- **desktop**: hover reveals row actions on right; click row for detail

## Skeleton

```html
<ul class="wf-stack" style="list-style:none;padding:0;margin:0">
  <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2);cursor:pointer">
    <div class="mock-img" style="width:40px;height:40px;border-radius:50%">SK</div>
    <div class="wf-grow">
      <div style="font-weight:500">Sarah Kim</div>
      <div class="wf-muted" style="font-size:13px">Engineering · Last active 2h ago</div>
    </div>
    <span class="wf-muted" aria-hidden="true">›</span>
  </li>
  <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2);cursor:pointer">
    <div class="mock-img" style="width:40px;height:40px;border-radius:50%">MD</div>
    <div class="wf-grow">
      <div style="font-weight:500">Maneesh Dhabria</div>
      <div class="wf-muted" style="font-size:13px">Product · Last active 1d ago</div>
    </div>
    <span class="wf-muted" aria-hidden="true">›</span>
  </li>
</ul>
```
