# Progress Indicator

## When to use
- Showing progress through a known-length task (file upload, multi-step form, onboarding)
- Long operations with measurable progress

## When NOT to use
- Indeterminate operations → use a spinner with context
- Very fast operations < 300 ms → no indicator
- Loading content → [loading-skeleton.md](../feedback/loading-skeleton.md)

## Anatomy
1. Linear bar OR circular ring
2. Filled portion representing percent complete
3. Optional: percent label
4. Optional: step labels for stepwise progress
5. ARIA: `role="progressbar"` with `aria-valuenow` / `aria-valuemin` / `aria-valuemax`

## Required states
- 0% (just started)
- in-progress (partial fill)
- nearly-complete
- complete (100%)
- error / paused
- indeterminate (use spinner instead, or animated stripes if linear)

## Best practices
1. Use linear bar for tasks; circular for compact spaces (G3)
2. Show percent or step label so users have a number anchor (N1)
3. For multi-step flows, prefer step indicators ("Step 2 of 4") over pure percent — more meaningful (N1)
4. Don't shrink progress when more work is discovered — feels broken; recompute upfront if possible (N1)
5. Accessibility: `role="progressbar"`, `aria-valuenow`, `aria-valuemin`, `aria-valuemax`, `aria-label` (A1, A4)
6. Color the fill with accent; background with neutral (G2, A2)
7. For indeterminate, use animated stripes / shimmer rather than fake progress (N1)
8. Show ETA only if confident — bad ETAs erode trust

## Common mistakes
- Progress that goes backward → user thinks it's broken (N1)
- Indeterminate progress that looks determinate → false impression (N1)
- No percent or label → vague feedback (N1)
- Tiny bar < 4 px tall → hard to perceive (A2)
- Color-only state (success/error) without text → fails colorblind (A2)

## Device variants
- **all devices**: same pattern; bars stretch to container width

## Skeleton

```html
<!-- Linear progress bar -->
<div class="wf-stack" style="max-width:480px">
  <div class="wf-row" style="justify-content:space-between;font-size:13px">
    <span>Uploading release-notes.pdf</span>
    <span class="wf-muted">62%</span>
  </div>
  <div role="progressbar" aria-valuenow="62" aria-valuemin="0" aria-valuemax="100"
       aria-label="Upload progress"
       style="height:8px;background:var(--wf-border-2);border-radius:4px;overflow:hidden">
    <div style="width:62%;height:100%;background:var(--wf-accent)"></div>
  </div>
</div>

<!-- Stepwise progress -->
<ol class="wf-row" style="list-style:none;padding:0;margin:0;gap:0;font-size:13px">
  <li class="wf-row" style="flex:1;gap:.5rem">
    <span class="mock-pill" style="background:var(--wf-success);color:#fff">✓</span>
    <span>Account</span>
  </li>
  <li class="wf-row" style="flex:1;gap:.5rem">
    <span class="mock-pill" style="background:var(--wf-accent);color:#fff" aria-current="step">2</span>
    <strong>Plan</strong>
  </li>
  <li class="wf-row" style="flex:1;gap:.5rem">
    <span class="mock-pill">3</span><span class="wf-muted">Payment</span>
  </li>
</ol>

<!-- Indeterminate -->
<div role="progressbar" aria-label="Loading"
     style="height:4px;background:var(--wf-border-2);border-radius:4px;overflow:hidden;position:relative">
  <div style="position:absolute;width:30%;height:100%;background:var(--wf-accent);animation:wf-pulse 1.4s ease-in-out infinite"></div>
</div>
```
