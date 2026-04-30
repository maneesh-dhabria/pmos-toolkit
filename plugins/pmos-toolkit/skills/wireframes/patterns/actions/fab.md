# FAB (Floating Action Button)

## When to use
- Mobile/native primary creation action ("New post", "+ Compose")
- Single dominant action that should be reachable from anywhere on the screen

## When NOT to use
- Desktop primary action → use a [primary-cta.md](primary-cta.md) in the page header
- Multiple peer actions → use a header action group, not multiple FABs
- iOS apps where FAB isn't the convention — prefer top-right "+" in nav bar (D3)

## Anatomy
1. Circular (or pill) button floating above content
2. Icon (action verb) — "+" most common
3. Optional: extended FAB with label ("+ New deal")
4. Anchored to screen corner (typically bottom-right above the tab bar)

## Required states
- default
- pressed (ripple)
- with-extended-label
- with-mini-fab (smaller variant)
- scrolled-state (some products hide on scroll-down, show on scroll-up)

## Best practices
1. ONE FAB per screen (G3)
2. Position above the bottom-tab-bar with margin so it doesn't collide (D2, F1)
3. ≥ 56×56 px (D2, F1, A5)
4. Material convention: 16 px from screen edges; iOS doesn't use FAB conventionally (D3)
5. Extended FAB (with label) for first-run / unfamiliar contexts; collapses to icon-only when user scrolls (N6, N7)
6. `aria-label` describing the action (A4)
7. Consider scroll-to-bottom collision: hide or shrink on scroll
8. Don't use a FAB AND a header CTA for the same action — pick one

## Common mistakes
- Multiple FABs → none feels primary (G3)
- FAB on iOS where users expect "+" in nav bar (D3)
- FAB collides with bottom tab bar → inaccessible (F1)
- Tiny FAB (< 48 px) → fails touch (F1, A5)
- FAB on desktop → wastes screen real estate; use header CTA instead

## Device variants
- **android-app**: standard pattern; bottom-right, above tab bar
- **ios-app**: not a native pattern; prefer top-right "+" in nav bar
- **mobile-web**: FAB-style works; ensure it doesn't cover content

## Skeleton

```html
<button class="wf-fab" aria-label="New deal">+</button>

<!-- Extended FAB -->
<button class="wf-fab" style="width:auto;border-radius:28px;padding:0 20px;font-weight:600;gap:.5rem"
        aria-label="New deal">+ New deal</button>
```
