# Detail View

## When to use
- Single entity's full data: a deal, a user, a document, a setting group
- Reached from a list, table, or card grid
- Read-heavy with optional edit affordances

## When NOT to use
- Comparing multiple entities → [table.md](table.md)
- Editing only → use a form pattern; detail view is read-first
- Trivial data (1–2 fields) → consider inline display

## Anatomy
1. [page-header.md](../layout/page-header.md): entity title, status, primary actions
2. Metadata strip: created/owner/status etc. (use [key-value-pair.md](key-value-pair.md))
3. Body sections (one per logical group): description, activity, related items
4. Side rail (optional, desktop): related actions, secondary metadata
5. Activity log / comments at the bottom
6. Optional: sticky save/edit bar when in edit mode

## Required states
- view (read-only)
- edit (mutable fields)
- with-pending-changes (unsaved)
- saving
- saved
- with-permission-denied (read-only because user lacks edit rights)
- entity-deleted / archived

## Best practices
1. Title is the entity name, large; status pill next to it (G3, N1)
2. Use sections with bold headings; each addresses one question ("Description", "Activity", "Members") (G3)
3. Edit mode: show what's editable with field affordances; "Save" / "Cancel" sticky at bottom or top (N3)
4. Show "last updated by X at Y" (N1) — accountability
5. Permissions: if user can't edit, hide edit affordances entirely; don't show disabled buttons everywhere (N8)
6. Activity log in reverse chronological (newest first) (N4)
7. Mobile: collapse side rail into accordions or tabs

## Common mistakes
- Edit form alongside read view → confusing; pick one mode at a time (N4)
- Same-style headings everywhere → no scan-able hierarchy (G3)
- Save button at the top only → user has to scroll back up after editing (N7, F1)
- No "last updated" indicator → users distrust freshness (N1)
- Sidebar of metadata on mobile → wastes 30% width; collapse it

## Device variants
- **desktop-web/-app**: two-column with side rail
- **mobile-web/native**: single column; collapse side rail content into accordions or a "Details" tab

## Skeleton

```html
<header class="wf-row" style="justify-content:space-between;align-items:flex-start;gap:1rem">
  <div>
    <div class="wf-row">
      <h1 style="font-size:24px;margin:0">Acme Pilot Q3 Renewal</h1>
      <span class="mock-pill" style="background:var(--wf-warning);color:#fff">Negotiation</span>
    </div>
    <div class="wf-muted" style="font-size:13px;margin-top:.25rem">Owned by Sarah Kim · Updated 2h ago</div>
  </div>
  <div class="wf-row">
    <button class="mock-button">Edit</button>
    <button class="mock-button mock-button--primary">Mark won</button>
  </div>
</header>

<hr class="mock-divider">

<div style="display:grid;grid-template-columns:2fr 1fr;gap:1.5rem">
  <main class="wf-stack">
    <section>
      <h2 class="mock-label">Description</h2>
      <p>Renewal of existing 12-month pilot. Customer requested expanded SSO and audit-log support.</p>
    </section>
    <section>
      <h2 class="mock-label">Activity</h2>
      <ul class="wf-stack" style="list-style:none;padding:0">
        <li class="wf-row"><span>📞</span><div><strong>Sarah Kim</strong> logged a call · 2h ago</div></li>
        <li class="wf-row"><span>✏️</span><div><strong>Sarah Kim</strong> updated value to $48,000 · 1d ago</div></li>
      </ul>
    </section>
  </main>
  <aside class="wf-stack">
    <div class="mock-card">
      <div class="mock-label">Value</div>
      <div class="wf-mono" style="font-size:20px">$48,000</div>
    </div>
    <div class="mock-card">
      <div class="mock-label">Close date</div>
      <div>Jun 30, 2026</div>
    </div>
  </aside>
</div>
```
