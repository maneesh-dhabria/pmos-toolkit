# Page Header

## When to use
- Top of every content page
- Provides title, context, and page-level actions

## When NOT to use
- Inside modals → modal has its own header
- Auth screens (login, signup) — typically have a centered focal layout, no traditional header
- Embedded views (iframes, widgets)

## Anatomy
1. Optional: [breadcrumbs.md](../navigation/breadcrumbs.md) above title
2. Title (H1)
3. Optional: description / subtitle
4. Optional: status / metadata strip
5. Page-level actions on the right ([primary-cta.md](../actions/primary-cta.md) + secondary)
6. Optional: tabs below the header ([tabs.md](../navigation/tabs.md))

## Required states
- default
- with-breadcrumbs
- with-tabs-below
- with-loading-title (during fetch)
- with-status-pill
- mobile-collapsed (actions in overflow menu)

## Best practices
1. Title is the most prominent text on the page (G3) — big, bold
2. Page-level actions right-aligned (N4)
3. ≤ 1 primary + ≤ 2 secondary actions visible; rest in overflow (F2)
4. Status pill next to title for stateful entities (N1)
5. Breadcrumbs above title for hierarchical IA (N6)
6. Sticky on scroll only for long pages where actions need to be reachable (N7)
7. Mobile: collapse actions into overflow `⋯`; primary becomes a sticky bottom button if critical (D1, F1)
8. ARIA: `<header>` element, title is `<h1>` (A1)

## Common mistakes
- Multiple H1s on a page → confuses hierarchy and screen readers (A1, G3)
- 5+ buttons in the header → overflow noise (F2)
- Title same size as section headings → no scan hierarchy (G3)
- Breadcrumbs that duplicate the title (last crumb = page title is fine; whole header redundant isn't) (N8)
- Mobile keeps all desktop actions inline → overflow / wrap (D1)

## Device variants
- **desktop**: full layout with all actions visible
- **mobile**: actions in overflow; primary may stick to bottom

## Skeleton

```html
<header style="margin-bottom:1.5rem">
  <nav aria-label="Breadcrumb" style="margin-bottom:.5rem;font-size:13px">
    <ol class="wf-row" style="list-style:none;padding:0;margin:0;gap:.5rem">
      <li><a href="#" class="wf-muted">Workspaces</a></li>
      <li class="wf-muted" aria-hidden="true">›</li>
      <li><a href="#" class="wf-muted">Acme</a></li>
      <li class="wf-muted" aria-hidden="true">›</li>
      <li aria-current="page">Deals</li>
    </ol>
  </nav>

  <div class="wf-row" style="justify-content:space-between;align-items:flex-start;gap:1rem">
    <div>
      <div class="wf-row">
        <h1 style="font-size:24px;margin:0">Deals</h1>
        <span class="mock-pill">47 open</span>
      </div>
      <p class="wf-muted" style="margin:.25rem 0 0">Track and update opportunities across the pipeline.</p>
    </div>
    <div class="wf-row">
      <button class="mock-button">Import</button>
      <button class="mock-button">Export</button>
      <button class="mock-button mock-button--primary">+ New deal</button>
    </div>
  </div>
</header>
```
