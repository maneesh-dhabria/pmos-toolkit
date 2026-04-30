# Hamburger Menu

## When to use
- Mobile primary nav when there's no room for a bottom-tab-bar AND destinations are infrequent
- Desktop **secondary/overflow** menu only
- Sites where nav is rarely the user's reason for being there (content sites, marketing)

## When NOT to use
- Mobile primary nav for an app users use daily → [bottom-tab-bar.md](bottom-tab-bar.md) is better (visible > hidden)
- Desktop primary nav with screen real estate → [top-nav.md](top-nav.md) or [side-nav.md](side-nav.md). Hamburger on desktop hides nav unnecessarily.

## Anatomy
1. Trigger button (the three-line icon, labeled "Menu" for accessibility)
2. Drawer / overlay panel that slides in
3. Destination list inside the drawer
4. Close affordance (X button + tap-outside + Esc key)
5. Scrim/overlay behind drawer

## Required states
- default (closed)
- open (drawer visible)
- with-active-item
- nested-section-expanded (if hierarchical)

## Best practices
1. Always pair the icon with the word "Menu" or `aria-label="Menu"` (A4, N6)
2. Drawer slides from the same side every time (N4) — left for LTR languages
3. Tap-outside, Esc, AND visible X button all close it (N3)
4. Trap focus inside the drawer when open (A1, A3)
5. Animate in 200–300 ms — instant feels jarring, longer feels sluggish
6. Width: ~80% of viewport on mobile, 280–320 px on desktop overflow
7. Background scrim at ~50% opacity dark — dims context without losing it (G4)

## Common mistakes
- Three-line icon with no label → many users (especially older / less digital-native) don't recognize it (N6)
- No way to close except tap-outside → keyboard users locked out (A3)
- Hides destinations users need on every visit → recognition over recall fails (N6). Use bottom-tab-bar instead.
- Drawer covers entire screen → users lose orientation. Leave a 10–20% peek of the underlying content.
- Animation > 400 ms → feels slow

## Device variants
- **mobile-web**: full-height left drawer, ~80% width
- **desktop-web/-app**: only as overflow ("more options"), never as primary nav
- **native**: prefer system drawer patterns (Material navigation drawer, iOS sheet)

## Skeleton

```html
<button class="mock-button" aria-label="Open menu" aria-expanded="false" aria-controls="drawer">☰ Menu</button>

<!-- Drawer (state-conditional) -->
<div role="dialog" aria-modal="true" aria-label="Primary navigation" id="drawer"
     style="position:fixed;inset:0 30% 0 0;background:var(--wf-surface);box-shadow:var(--wf-shadow);padding:1rem;z-index:50">
  <div class="wf-row">
    <strong>Acme</strong>
    <button class="mock-button ml-auto" aria-label="Close menu">×</button>
  </div>
  <hr class="mock-divider">
  <nav class="wf-stack">
    <a href="#" class="mock-button" style="justify-content:flex-start">Dashboard</a>
    <a href="#" class="mock-button" style="justify-content:flex-start">Pipelines</a>
    <a href="#" class="mock-button" style="justify-content:flex-start">Reports</a>
  </nav>
</div>
<!-- Scrim -->
<div style="position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:40"></div>
```
