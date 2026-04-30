# Side Navigation

## When to use
- Apps with **8+ destinations** or hierarchical IA (sections containing pages)
- Productivity / admin tools where users spend long sessions
- Desktop-first products

## When NOT to use
- Marketing/content sites → use [top-nav.md](top-nav.md)
- Mobile primary → use [bottom-tab-bar.md](bottom-tab-bar.md) or hamburger drawer
- < 5 destinations → top-nav is lighter

## Anatomy
1. Brand / workspace selector (top)
2. Primary destination groups with section headers
3. Active-item highlight (full-width pill or left border)
4. Collapse/expand toggle (optional, persists per user)
5. Footer: account, help, settings (bottom)

## Required states
- default expanded
- collapsed (icons only)
- with-active-item
- with-nested-group (expanded section)
- with-nested-group (collapsed section)

## Best practices
1. Group related destinations with bold section headers (G3) — flat lists of 12+ are unscannable
2. Active item uses fill + weight, not just color (A2)
3. Icons + labels by default; collapsed state shows icons with tooltips (N6, N10)
4. Nested groups: max 1 level deep (F2) — deeper trees lose users
5. Keep width 240–280 px expanded, 64 px collapsed (G4)
6. Workspace switcher pinned at top, account at bottom — universal in productivity tools (N4)
7. Persist collapse state across sessions (N7)

## Common mistakes
- 3+ levels of nested groups → users lose track of where they are. Promote frequent destinations to top level.
- Icons without tooltips when collapsed → fails recognition (N6)
- Active state only changes text color → poor contrast (A2)
- No section headers in a 15-item list → cognitive overload (F2)
- Side nav on mobile → wastes 30% of viewport. Convert to drawer.

## Device variants
- **desktop-web/-app**: persistent, collapsible
- **mobile-web**: convert to slide-in drawer triggered by hamburger
- **native**: prefer bottom-tab-bar; side-nav only as drawer

## Skeleton

```html
<aside class="mock-sidebar" aria-label="Primary navigation" style="width:260px">
  <div class="wf-row" style="padding:.75rem">
    <div class="mock-pill">Acme Workspace ▾</div>
  </div>
  <hr class="mock-divider">
  <nav class="wf-stack" style="padding:.5rem">
    <div class="mock-label">Workspace</div>
    <a href="#" class="mock-button" style="justify-content:flex-start;background:var(--wf-accent);color:#fff">Dashboard</a>
    <a href="#" class="mock-button" style="justify-content:flex-start">Pipelines</a>
    <a href="#" class="mock-button" style="justify-content:flex-start">Deployments</a>
    <div class="mock-label" style="margin-top:.75rem">Team</div>
    <a href="#" class="mock-button" style="justify-content:flex-start">Members</a>
    <a href="#" class="mock-button" style="justify-content:flex-start">Roles</a>
  </nav>
  <hr class="mock-divider">
  <div class="wf-row" style="padding:.5rem;margin-top:auto">
    <button class="mock-button" aria-label="Account">MD</button>
    <span class="wf-muted">Maneesh</span>
  </div>
</aside>
```
