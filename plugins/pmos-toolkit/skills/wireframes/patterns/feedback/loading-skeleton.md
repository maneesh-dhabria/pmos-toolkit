# Loading Skeleton

## When to use
- Content loading > 300 ms
- Page-level OR component-level loading
- Where layout is predictable enough to mirror in skeleton form

## When NOT to use
- Loads < 300 ms → no indicator needed (flash worsens UX)
- Indeterminate loads where layout is unknown → spinner with context
- Action-triggered loads (button click) → button-internal spinner

## Anatomy
1. Skeleton blocks matching the shape of the real content
2. Optional: shimmer/pulse animation
3. Same dimensions as loaded content (prevents layout shift)
4. ARIA: `aria-busy="true"` on the parent; `aria-live` for screen readers

## Required states
- loading (skeleton visible)
- loaded (skeleton replaced by real content)
- error (replaced by error state)
- initial-load vs reload

## Best practices
1. Match the SHAPE of the content (N4) — table rows in a table, cards in a grid, lines in a list
2. Same dimensions as loaded content prevents layout shift (N4) — biggest UX win
3. Subtle pulse animation, 1.4s ease-in-out — not jarring (N8)
4. Show within 100 ms of load start; hide as soon as content arrives (N1)
5. For < 300 ms loads, skip skeletons entirely (N1)
6. `aria-busy="true"` on container while loading; remove when loaded (A1)
7. Don't show full-page spinner over a half-loaded page — use skeletons in place (N1)
8. For very long loads (> 5s), supplement with a contextual message ("Crunching the numbers…") (N1)

## Common mistakes
- Generic spinner where skeleton would work better → no preview of layout (N1)
- Skeleton dimensions mismatch real content → layout shift on load (N4)
- Skeleton on every reload, even cached views → flicker (N1)
- Skeleton shapes that look like real content → users try to interact (N2)
- No accessibility — screen readers announce nothing (A1)

## Device variants
- **desktop / mobile**: same approach; ensure skeleton matches each viewport's actual layout

## Skeleton

```html
<!-- Page-level: list with skeleton items -->
<ul aria-busy="true" class="wf-stack" style="list-style:none;padding:0;margin:0">
  <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2)">
    <div class="skeleton" style="width:40px;height:40px;border-radius:50%"></div>
    <div class="wf-grow wf-stack">
      <div class="skeleton skeleton--lg" style="width:40%"></div>
      <div class="skeleton" style="width:60%"></div>
    </div>
  </li>
  <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2)">
    <div class="skeleton" style="width:40px;height:40px;border-radius:50%"></div>
    <div class="wf-grow wf-stack">
      <div class="skeleton skeleton--lg" style="width:35%"></div>
      <div class="skeleton" style="width:70%"></div>
    </div>
  </li>
</ul>

<!-- Card-level skeleton -->
<article class="mock-card" aria-busy="true">
  <div class="skeleton" style="aspect-ratio:16/10;height:auto;margin-bottom:.75rem"></div>
  <div class="skeleton skeleton--lg" style="width:70%;margin-bottom:.5rem"></div>
  <div class="skeleton" style="width:50%"></div>
</article>
```
