# Sidebar + Detail (List/Detail)

## When to use
- Inbox-style apps (mail, messages, tickets)
- File browsers
- Any flow where users repeatedly pick from a list and view detail without losing list context

## When NOT to use
- Lists with detail-rich items → list page → detail page (separate routes)
- Browsing by visual preview → [card-grid.md](../data-display/card-grid.md)
- Mobile primary surface → use list-then-detail navigation, not split view

## Anatomy
1. Left list pane (300–400 px)
2. Right detail pane (rest of width)
3. List item shows: leading avatar/icon, title, snippet, timestamp, unread indicator
4. Selected list item highlighted; detail pane shows full content
5. Required: empty detail pane when nothing selected ("Select an item")

## Required states
- nothing-selected (empty detail pane)
- with-selection (detail rendered)
- with-multi-select (checkbox column)
- list-loading
- detail-loading
- list-empty
- detail-empty (item deleted while viewing)

## Best practices
1. Selected list item: filled background + border accent (G2, A2)
2. Detail pane fetches in-place; show skeleton during fetch (N1)
3. Keyboard: arrow keys navigate list, Enter opens detail (A3) — power-user expectation
4. Empty detail pane shows guidance: "Select a message to read" (N9)
5. Unread/read state visually distinct (weight + indicator dot) (G3, A2)
6. Sticky list filter / search at the top of the list pane
7. On mobile: split view collapses; tapping list item opens full-screen detail with back button (D1)
8. Use ARIA `role="list"` for the list, `aria-selected` for the active item (A1)

## Common mistakes
- Selected state only via background color → fails colorblind (A2)
- Detail pane reloads page (full route change) on selection → loses list scroll position
- No keyboard navigation → power users frustrated (A3)
- Empty detail pane is just blank → looks broken (N9)
- Mobile retains side-by-side → cramped (D1)

## Device variants
- **desktop**: side-by-side
- **tablet landscape**: side-by-side
- **tablet portrait / mobile**: list view → tap → detail view (full screen with back)

## Skeleton

```html
<div style="display:grid;grid-template-columns:340px 1fr;gap:1px;background:var(--wf-border-2);min-height:600px">

  <!-- List pane -->
  <aside style="background:var(--wf-surface);overflow-y:auto">
    <div style="padding:.5rem;position:sticky;top:0;background:var(--wf-surface);border-bottom:1px solid var(--wf-border-2)">
      <input type="search" class="mock-input" placeholder="Search…">
    </div>
    <ul style="list-style:none;padding:0;margin:0">
      <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2);background:var(--wf-accent);color:#fff" aria-selected="true">
        <div class="mock-img" style="width:36px;height:36px;border-radius:50%;background:rgba(255,255,255,.2);border:0">SK</div>
        <div class="wf-grow">
          <div style="font-weight:600">Sarah Kim</div>
          <div style="font-size:13px;opacity:.85">Re: Q3 renewal terms</div>
        </div>
        <div style="font-size:11px;opacity:.85">2h</div>
      </li>
      <li class="wf-row" style="padding:.75rem;border-bottom:1px solid var(--wf-border-2)">
        <div class="mock-img" style="width:36px;height:36px;border-radius:50%">MD</div>
        <div class="wf-grow">
          <div style="font-weight:500">Maneesh Dhabria</div>
          <div class="wf-muted" style="font-size:13px">Pipeline review notes</div>
        </div>
        <div class="wf-muted" style="font-size:11px">1d</div>
      </li>
    </ul>
  </aside>

  <!-- Detail pane -->
  <main style="background:var(--wf-surface);padding:1.5rem;overflow-y:auto">
    <header style="margin-bottom:1rem">
      <h1 style="margin:0;font-size:20px">Re: Q3 renewal terms</h1>
      <div class="wf-muted" style="font-size:13px">From Sarah Kim · 2h ago</div>
    </header>
    <article>
      <p>Hi team — confirming the updated commercial terms below…</p>
    </article>
  </main>
</div>
```
