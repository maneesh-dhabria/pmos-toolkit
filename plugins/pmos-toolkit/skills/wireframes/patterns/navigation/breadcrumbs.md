# Breadcrumbs

## When to use
- Hierarchical IA, **3+ levels deep**
- Users land on deep pages from search/links and need orientation
- Showing parent context aids the task

## When NOT to use
- Flat IA (1–2 levels) → no value, just clutter
- The page has its own clear "Back to X" affordance
- Single-step flows where there's nothing meaningful above

## Anatomy
1. Sequence of parent-page links from root → current
2. Separator between items (chevron `›` or `/`)
3. Current page as plain text (NOT a link to itself)
4. Optional: truncation for very deep paths (`Home › ... › Project › Settings`)

## Required states
- default
- truncated (long path with ellipsis)
- mobile-collapsed (only "‹ Parent" shown)

## Best practices
1. Render at the top of the content area, BELOW the primary nav (N4)
2. Current page is plain text, not a link (N3) — users shouldn't click their current location
3. Use real page titles, not section IDs (N2)
4. Separator `›` or `/`, never `>` (typography matters; G3)
5. Mark up with `<nav aria-label="Breadcrumb">` and `<ol>` for screen readers (A1)
6. Use `aria-current="page"` on the last item (A1)
7. On mobile, collapse to single back-link "‹ Parent" — full trail is unreadable (D1, F1)

## Common mistakes
- Breadcrumbs on a flat 2-level site → adds chrome with no value (N8)
- Last item is a link to itself → confusing (N3)
- Showing only 2 levels when path is 5 deep → fails the orientation purpose
- Replaces back button → breadcrumbs are NOT history; they're location
- Truncates the current page name → users lose the "you are here" anchor

## Device variants
- **desktop-web/-app**: full path
- **mobile-web**: single back-link "‹ {Parent}"
- **native**: typically not used; native back gesture handles it

## Skeleton

```html
<nav aria-label="Breadcrumb" class="wf-row" style="font-size:13px">
  <ol class="wf-row" style="list-style:none;padding:0;margin:0;gap:.5rem">
    <li><a href="#" class="wf-muted">Workspaces</a></li>
    <li class="wf-muted" aria-hidden="true">›</li>
    <li><a href="#" class="wf-muted">Acme</a></li>
    <li class="wf-muted" aria-hidden="true">›</li>
    <li><a href="#" class="wf-muted">Projects</a></li>
    <li class="wf-muted" aria-hidden="true">›</li>
    <li aria-current="page">Q3 Planning</li>
  </ol>
</nav>
```
