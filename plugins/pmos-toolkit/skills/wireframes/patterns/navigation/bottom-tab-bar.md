# Bottom Tab Bar

## When to use
- Mobile/native primary navigation, **3–5 destinations**
- Destinations are peer-level (none is parent of another)
- Users switch between them frequently

## When NOT to use
- Desktop → use [top-nav.md](top-nav.md) or [side-nav.md](side-nav.md)
- 6+ destinations → use side drawer or grouped nav
- Hierarchical IA → bottom bar implies peers

## Anatomy
1. 3–5 tab buttons, equal width
2. Each tab: icon + label (label is mandatory)
3. Active-tab indicator (color + weight, plus filled icon variant)
4. Optional: badge on tabs with unread/pending state

## Required states
- default
- with-active-tab (one selected)
- with-badge (notification count on a tab)
- pressed (touch feedback)

## Best practices
1. Always show labels — icon-only fails recognition for non-experts (N6, N2)
2. Active tab: filled icon + accent color + weight (G2, A2)
3. 44×44 minimum touch target, 48×48 preferred (F1, A5)
4. iOS: tab bar at bottom, ~49pt height. Android: bottom nav, 56dp height (D2, D3)
5. Never put the FAB IN the tab bar — overlap with [fab.md](fab.md), don't merge
6. Tab order matches information importance, not alphabetical (N4)
7. Tapping the active tab scrolls to top of that section (N7) — established convention

## Common mistakes
- Only 2 tabs → use [tabs.md](tabs.md) inside a screen instead
- 6+ tabs → forces tiny targets and crowds labels (F1, F2). Group into a "More" tab or switch to drawer.
- Icon-only → fails recognition (N6)
- Hides on scroll → users lose orientation; only acceptable in immersive views like maps/video
- Used on desktop → wastes vertical space and feels like a mobile port

## Device variants
- **ios-app**: SF Symbols, label below icon, blur background
- **android-app**: Material icons, label below icon, elevated surface
- **mobile-web**: similar to android, slightly looser proportions

## Skeleton

```html
<nav class="wf-tabbar" role="tablist" aria-label="Primary">
  <button role="tab" aria-selected="true" class="wf-stack" style="text-align:center;color:var(--wf-accent)">
    <span aria-hidden="true">🏠</span><span style="font-size:11px">Home</span>
  </button>
  <button role="tab" aria-selected="false" class="wf-stack wf-muted" style="text-align:center">
    <span aria-hidden="true">🔍</span><span style="font-size:11px">Search</span>
  </button>
  <button role="tab" aria-selected="false" class="wf-stack wf-muted" style="text-align:center;position:relative">
    <span aria-hidden="true">🔔</span><span style="font-size:11px">Inbox</span>
    <span class="mock-pill" style="position:absolute;top:-2px;right:8px;background:var(--wf-error);color:#fff">3</span>
  </button>
  <button role="tab" aria-selected="false" class="wf-stack wf-muted" style="text-align:center">
    <span aria-hidden="true">👤</span><span style="font-size:11px">Profile</span>
  </button>
</nav>
```
