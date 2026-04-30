# Badge

## When to use
- Status indicator (Open / Closed / Negotiation)
- Count indicator (notifications, unread)
- Category tag (Bug, Feature, Docs)

## When NOT to use
- Primary action → use a button
- Long descriptive text → use a normal text element
- Color-only categorization without text → fails accessibility

## Anatomy
1. Pill or rounded-rectangle container
2. Color-coded by semantic (success / warning / error / neutral)
3. Concise label OR number
4. Optional: icon (sparingly)

## Required states
- neutral
- success / positive
- warning
- error / critical
- info
- with-icon
- count (just number, e.g., "3")
- count-overflow ("99+")

## Best practices
1. Color + text label (A2) — never color alone for meaning
2. Concise: ≤ 2 words for status; just a number for counts (G3, N8)
3. Consistent color mapping across the app (N4) — green for success, red for error, etc.
4. Use neutral pill for category/tag — don't over-color (G2, N8)
5. Counts: cap at "99+" — never show "1,247" in a small pill (G3)
6. Don't put badges inside badges
7. Status badges next to entity title; counts next to nav items
8. Border + light fill for accessibility in dark mode (A2)

## Common mistakes
- Color-only with no text → fails colorblind (A2)
- Every tag in saturated color → loses signal; reserve color for important states (N8)
- Inconsistent color meaning → "Red" means error here, "warning" elsewhere (N4)
- Tiny font (< 11 px) for accessibility (A2)

## Device variants
- **all devices**: same pattern

## Skeleton

```html
<!-- Status badges -->
<span class="mock-pill" style="background:#dcfce7;color:#166534;border-color:#bbf7d0">● Active</span>
<span class="mock-pill" style="background:#fef3c7;color:#92400e;border-color:#fde68a">● Pending</span>
<span class="mock-pill" style="background:#fee2e2;color:#991b1b;border-color:#fecaca">● Failed</span>
<span class="mock-pill">Draft</span>

<!-- Count badge -->
<button class="mock-button" aria-label="Notifications, 12 unread" style="position:relative">
  🔔
  <span class="mock-pill" style="position:absolute;top:-4px;right:-4px;background:var(--wf-error);color:#fff;border:2px solid var(--wf-surface);min-width:20px;text-align:center">12</span>
</button>

<!-- Overflow -->
<span class="mock-pill" style="background:var(--wf-error);color:#fff">99+</span>

<!-- With icon -->
<span class="mock-pill" style="background:#dbeafe;color:#1e40af">⚡ Beta</span>
```
