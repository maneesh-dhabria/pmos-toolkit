# Two-Column Layout

## When to use
- Persistent navigation/filter pane + main content area
- Settings (categories on left, settings on right)
- Apps with side-nav as primary navigation

## When NOT to use
- Marketing pages → centered layout
- Mobile (no horizontal room) → stack vertically or use a drawer
- Equal-importance content blocks → grid layout

## Anatomy
1. Left column: persistent rail (nav, filters, categories)
2. Right column: main content (much wider, ~65–80% of width)
3. Optional: top header spanning both columns
4. Optional: collapse toggle for the left rail

## Required states
- default (both columns visible)
- with-collapsed-rail (icons only)
- mobile-stacked (rail hidden behind drawer or moved to top)
- with-rail-overflow-scroll (long category list)

## Best practices
1. Left column 200–280 px (G4) — enough for labels, not too much chrome
2. Main column gets the rest of the width (G4)
3. Persistent active state in the rail showing current section (N1)
4. Allow rail collapse for power users (N7)
5. Sticky rail on scroll so user doesn't lose orientation when scrolling main content (N6)
6. Mobile: rail becomes a drawer or reorders above content (D1)
7. Use `<aside>` for the rail and `<main>` for content (A1)
8. Maintain at least 24 px gutter between columns (G4)

## Common mistakes
- 50/50 split → main content cramped (G4)
- Rail wider than content on small viewports → bad density (G4)
- No active-state in rail → user disoriented (N1)
- Both columns scroll independently with no clear relationship → confusing (N6)
- Rail scrolls but main content also scrolls a different amount → vertigo

## Device variants
- **desktop-web/-app**: persistent two-column
- **mobile-web**: rail as drawer; or stack rail content above
- **native**: rail typically hidden behind drawer or moved to bottom-tab-bar

## Skeleton

```html
<div style="display:grid;grid-template-columns:240px 1fr;gap:1.5rem;min-height:600px">
  <aside class="mock-sidebar" style="width:auto;height:fit-content;position:sticky;top:1rem">
    <div class="wf-stack">
      <div class="mock-label">Settings</div>
      <a href="#" class="mock-button" style="justify-content:flex-start;background:var(--wf-accent);color:#fff">General</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Billing</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Members</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Integrations</a>
      <a href="#" class="mock-button" style="justify-content:flex-start">Audit log</a>
    </div>
  </aside>

  <main class="mock-content">
    <h1 style="margin:0">General</h1>
    <p class="wf-muted">Workspace name, default timezone, and locale.</p>
    <!-- form / content -->
  </main>
</div>
```
