# Empty State

## When to use
- Container with no items YET (first-run, fresh account, just-cleared filter)
- Search returning zero results
- A list/table/grid in its empty form

## When NOT to use
- Loading (use skeleton, not empty)
- Error (use error-state)
- Transient zero-state user will refill via Undo → consider a softer "Nothing here" without CTA

## Anatomy
1. Centered illustration or icon (kept minimal in low-/mid-fi wireframes)
2. Title: states what's missing OR celebrates fresh start
3. Helper text: 1–2 sentences explaining why and what to do
4. Primary CTA to add the first item or change the filter
5. Optional: secondary link (docs, video tour)

## Required states
- first-run (never had content) — onboarding tone
- post-clear (had content, now zero) — neutral tone
- no-results (search/filter applied) — suggest changing filter
- permission-empty (user lacks access) — explain why

## Best practices
1. Title is specific to context: "No deals yet" not "Empty" (N2, N9)
2. Helper text explains WHY and what to do next (N9)
3. Primary CTA in the empty state matches the surface's primary creation action (N4)
4. First-run empty states can be aspirational ("Start tracking your deals to see your pipeline grow")
5. No-results empty state suggests fixes ("Try fewer keywords, or clear your filter") (N9)
6. Don't show empty state during initial load — show skeleton instead (N4)
7. Illustrations: kept geometric/abstract for wireframes — don't draft real art (G4, N8)
8. ARIA: announce empty via `aria-live="polite"` if dynamically appearing after a filter (A1)

## Common mistakes
- "No data" with nothing else → user can't tell if it's broken or expected (N9)
- Empty state on initial load (before fetch completes) → looks broken; use skeleton (N4)
- Generic empty illustration unrelated to the surface → noise (N8)
- No CTA → user knows there's nothing but doesn't know how to fix it
- Same empty state for "first-run" and "filtered to zero" → mixes contexts

## Device variants
- **desktop / mobile**: centered in container; mobile gets smaller illustration
- **native**: respect safe-area; use platform iconography

## Skeleton

```html
<!-- First-run empty -->
<div class="wf-message">
  <div class="placeholder" style="width:96px;height:96px;border-radius:50%"></div>
  <div class="wf-message__title">No deals yet</div>
  <div class="wf-message__hint">Track your sales pipeline by adding your first deal. You can import from CSV too.</div>
  <div class="wf-row" style="margin-top:.5rem">
    <button class="mock-button mock-button--primary">+ Add deal</button>
    <button class="mock-button">Import CSV</button>
  </div>
</div>

<!-- No-results empty -->
<div class="wf-message">
  <div class="wf-message__title">No matches for "renewall"</div>
  <div class="wf-message__hint">Check spelling or try fewer words.</div>
  <button class="mock-button" style="margin-top:.5rem">Clear filter</button>
</div>
```
