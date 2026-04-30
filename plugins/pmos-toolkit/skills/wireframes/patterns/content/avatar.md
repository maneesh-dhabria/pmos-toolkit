# Avatar

## When to use
- Identifying a user, organization, or entity
- Comments, list rows, mentions, attribution

## When NOT to use
- Decoration with no identity attached (use generic icon)
- Where identity matters but visual recognition doesn't (use just the name)

## Anatomy
1. Image (preferred), OR initials fallback, OR placeholder icon
2. Optional: status indicator dot (online/away/offline)
3. Optional: badge (admin, verified)

## Required states
- with-image (loaded)
- with-image-loading
- with-initials-fallback (no image)
- with-anonymous-fallback (no name either)
- with-status-online / -away / -offline
- multi-avatar-stack (overlapping for groups)

## Best practices
1. Always provide an `alt` text or `aria-label` (A4) — at minimum the user's name
2. Initials fallback: 1 letter for single names, 2 for first+last (G3)
3. Use deterministic background color from name hash (looks like design intent, not random) (G2)
4. Round or rounded-square — pick one and stick with it across the app (G2, N4)
5. Don't use real photos in low-/mid-fi wireframes — initials are clearer (N8)
6. Standard sizes: 24, 32, 40, 48, 64 px (G2)
7. Stacked avatars (group): overlap by ~30%, max ~4 visible + "+N more" (F2)
8. Status dot: 30% size of avatar, positioned bottom-right with white border (G2)

## Common mistakes
- Mixed shapes (round + square) on the same page → broken consistency (G2)
- No alt text → screen readers say nothing meaningful (A4)
- Random colors per render → flickers across reloads
- 6+ avatars in a stack → noise; cap at 4 + count (F2)
- Real photo placeholder in wireframes → conveys "design done" prematurely (N8)

## Device variants
- **all devices**: same pattern; sizes scale appropriately

## Skeleton

```html
<!-- Initials avatar -->
<span class="mock-img" style="width:40px;height:40px;border-radius:50%;background:#dbeafe;color:#1e40af;font-weight:600" aria-label="Sarah Kim">SK</span>

<!-- With status dot -->
<span style="position:relative;display:inline-block">
  <span class="mock-img" style="width:40px;height:40px;border-radius:50%;background:#fce7f3;color:#9f1239;font-weight:600" aria-label="Maneesh Dhabria">MD</span>
  <span aria-label="Online" style="position:absolute;bottom:0;right:0;width:12px;height:12px;border-radius:50%;background:var(--wf-success);border:2px solid var(--wf-surface)"></span>
</span>

<!-- Stacked group -->
<div class="wf-row" style="gap:0">
  <span class="mock-img" style="width:32px;height:32px;border-radius:50%;background:#fef3c7;color:#92400e;font-weight:600;border:2px solid var(--wf-surface)">SK</span>
  <span class="mock-img" style="width:32px;height:32px;border-radius:50%;background:#dbeafe;color:#1e40af;font-weight:600;border:2px solid var(--wf-surface);margin-left:-8px">MD</span>
  <span class="mock-img" style="width:32px;height:32px;border-radius:50%;background:#dcfce7;color:#166534;font-weight:600;border:2px solid var(--wf-surface);margin-left:-8px">AT</span>
  <span class="mock-pill" style="margin-left:-4px">+5</span>
</div>
```
