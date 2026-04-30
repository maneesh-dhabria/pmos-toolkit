# Top Navigation

## When to use
- Primary nav for desktop-web or desktop-app with **5–7 destinations**
- IA is flat or shallow (1–2 levels deep)
- Brand visibility matters (logo on the left)

## When NOT to use
- 8+ destinations → use [side-nav.md](side-nav.md)
- Mobile/native primary nav → use [bottom-tab-bar.md](bottom-tab-bar.md)
- Single-screen tool with no navigation → omit entirely

## Anatomy
1. Logo / wordmark (left, links to home)
2. Primary destinations (center or left-aligned)
3. Utility actions: search, notifications, account menu (right)
4. Active-state indicator on the current destination

## Required states
- default
- with-active-item (one destination highlighted)
- mobile-collapsed (links hidden behind hamburger; see [hamburger-menu.md](hamburger-menu.md))
- with-notification-badge

## Best practices
1. Use real labels, not icons alone (N2, A4) — icons require recall, not recognition
2. Mark the active destination with both color AND a non-color cue like a bottom border (A2)
3. Account menu collapses to a single avatar/button (F2) — never expose 5 utility links
4. Keep total height ≤ 64px desktop, 56px mobile (G4) — nav is chrome, not content
5. Logo is always a link to `/` (N4) — universal convention
6. Sticky on scroll only if the nav contains frequently-needed actions; otherwise let it scroll away (N8)
7. Tab order goes logo → destinations → utilities (A3)

## Common mistakes
- 10+ destinations crammed in → exceeds Hick's Law (F2). Group into a side nav or mega-menu.
- Icon-only destinations on desktop → fails recognition (N6). Add text labels.
- Active state shown only via color → fails contrast / colorblind users (A2). Add weight + underline.
- Hamburger on desktop with plenty of space → hides primary nav unnecessarily (N6).
- Logo not clickable → violates universal convention (N4).

## Device variants
- **mobile-web**: collapse destinations behind hamburger; keep logo + 1 utility (search or account) visible
- **desktop-web/-app**: full destinations visible
- **android-app/ios-app**: prefer [bottom-tab-bar.md](bottom-tab-bar.md) instead; top nav reserved for screen titles

## Skeleton

```html
<header class="mock-nav" role="navigation" aria-label="Primary">
  <a href="/" class="font-semibold">Acme</a>
  <nav class="flex gap-4 ml-4">
    <a href="#" class="font-medium border-b-2 border-current pb-0.5" aria-current="page">Dashboard</a>
    <a href="#" class="wf-muted">Pipelines</a>
    <a href="#" class="wf-muted">Reports</a>
    <a href="#" class="wf-muted">Team</a>
  </nav>
  <div class="ml-auto flex items-center gap-3">
    <input class="mock-input" placeholder="Search…" style="width:240px">
    <button class="mock-button" aria-label="Notifications">🔔<span class="mock-pill ml-1">3</span></button>
    <button class="mock-button" aria-label="Account">MD</button>
  </div>
</header>
```
