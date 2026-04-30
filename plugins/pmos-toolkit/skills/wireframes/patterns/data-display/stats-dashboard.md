# Stats Dashboard

## When to use
- Top-line metrics for at-a-glance scanning
- Home / overview pages
- Reporting summaries

## When NOT to use
- Single metric → just inline display
- Detailed analytics with drill-down → use a charts/analytics pattern (out of scope; show as `<div class="placeholder">Chart: …</div>`)
- Editable settings → key-value or settings-page

## Anatomy
1. Stat cards arranged in a grid (3–6 cards typical)
2. Per card: label, large value, optional trend (▲/▼ + delta), optional sparkline
3. Optional: time-range filter ("Last 7 days") above
4. Optional: "View report" link per card

## Required states
- default (with values)
- loading (skeleton numbers)
- empty / not-yet-tracked
- error
- with-trend-up / -down / -flat
- with-time-range-changed

## Best practices
1. Big number is the primary visual (G3) — that's why users came
2. Label small and muted ABOVE the number — Refactoring UI rule (G3)
3. Trend uses both color (green/red) AND arrow icon (▲/▼) (A2)
4. 3–6 cards max; more dilutes attention (F2)
5. Equal-width cards in a row (G2)
6. Loading: skeleton in the SAME shape as the loaded number (N1, N4)
7. Empty value: "—" or "Not enough data yet", never `0` if 0 is real but ambiguous (N1)
8. Tap/click for drill-down where it makes sense (N7)
9. Time-range filter at the top affects all cards consistently (N4)

## Common mistakes
- Tiny numbers, big labels → backwards (G3)
- Trend shown in color only → fails colorblind (A2)
- 10+ stat cards → user has no idea what to look at (F2)
- Different card sizes / heights in one row → ragged (G2)
- Showing "0" without context when the metric is just new → looks like a problem (N1)
- Loading shows generic spinner instead of skeleton numbers → layout shift on load

## Device variants
- **desktop-web/-app**: 3–4 cards per row
- **mobile-web**: 1–2 cards per row, cards stack
- **native**: same as mobile-web

## Skeleton

```html
<div class="wf-row" style="justify-content:space-between;margin-bottom:1rem">
  <h2 style="font-size:18px;margin:0">Pipeline overview</h2>
  <select class="mock-input" style="max-width:200px">
    <option>Last 7 days</option>
    <option>Last 30 days</option>
    <option>This quarter</option>
  </select>
</div>

<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:1rem">
  <div class="mock-card">
    <div class="mock-label">Open deals</div>
    <div style="font-size:32px;font-weight:600;margin-top:.25rem">47</div>
    <div style="color:var(--wf-success);font-size:13px;margin-top:.25rem">▲ 12% vs last week</div>
  </div>
  <div class="mock-card">
    <div class="mock-label">Pipeline value</div>
    <div class="wf-mono" style="font-size:32px;font-weight:600;margin-top:.25rem">$1.2M</div>
    <div style="color:var(--wf-error);font-size:13px;margin-top:.25rem">▼ 4% vs last week</div>
  </div>
  <div class="mock-card">
    <div class="mock-label">Win rate</div>
    <div style="font-size:32px;font-weight:600;margin-top:.25rem">28%</div>
    <div class="wf-muted" style="font-size:13px;margin-top:.25rem">— No change</div>
  </div>
  <!-- Loading variant -->
  <div class="mock-card">
    <div class="mock-label">Avg deal size</div>
    <div class="skeleton skeleton--lg" style="width:60%;margin-top:.5rem"></div>
    <div class="skeleton" style="width:80%;margin-top:.5rem"></div>
  </div>
</div>
```
