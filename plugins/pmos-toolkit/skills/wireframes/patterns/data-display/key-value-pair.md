# Key-Value Pair

## When to use
- Displaying entity attributes / metadata: created date, owner, status, etc.
- Settings readouts (read-only display of configured values)
- Receipt / summary blocks

## When NOT to use
- Editable fields → use form patterns
- Comparable rows of multiple entities → [table.md](table.md)
- Single piece of prominent info → use a stat card

## Anatomy
1. Key (label, muted, smaller)
2. Value (primary, larger)
3. Optional: inline action ("Copy", "Edit")
4. Layout: stacked (label above) OR inline (label left, value right)

## Required states
- default
- with-empty-value ("—" or "Not set")
- with-action-on-hover (Copy/Edit)
- pending-update (after inline edit)

## Best practices
1. Label is muted color, smaller (G3)
2. Value is primary color, normal/large (G3)
3. Empty values show "—" or "Not set", never blank (N1)
4. Group related pairs; separate groups with dividers or section headings (G1)
5. Inline layout for short values; stacked for long (G4)
6. "Copy" buttons on technical values (IDs, tokens, emails) (N7)
7. Use `<dl>` / `<dt>` / `<dd>` semantics (A1)
8. Truncate long values with ellipsis + tooltip showing full value

## Common mistakes
- Same visual weight for label and value → user can't scan (G3)
- Blank for empty values → user can't tell if it's loading or empty (N1)
- Long values that wrap awkwardly → set max-width and truncate
- 20+ pairs in a flat list → group them (G1, F2)

## Device variants
- **desktop**: inline layout (label left, value right)
- **mobile**: stacked layout (label above value) — saves horizontal space

## Skeleton

```html
<!-- Stacked variant -->
<dl class="wf-stack" style="margin:0">
  <div>
    <dt class="mock-label">Plan</dt>
    <dd style="margin:0">Business · Annual</dd>
  </div>
  <div>
    <dt class="mock-label">Renewal date</dt>
    <dd style="margin:0">Jun 30, 2026</dd>
  </div>
  <div>
    <dt class="mock-label">Workspace ID</dt>
    <dd style="margin:0" class="wf-row">
      <code class="wf-mono">ws_8H3kZ29p</code>
      <button class="mock-button" aria-label="Copy workspace ID">📋</button>
    </dd>
  </div>
  <div>
    <dt class="mock-label">Custom domain</dt>
    <dd class="wf-muted" style="margin:0">— Not set</dd>
  </div>
</dl>

<!-- Inline variant -->
<dl style="display:grid;grid-template-columns:max-content 1fr;gap:.5rem 1.5rem;margin:0">
  <dt class="mock-label">Plan</dt><dd style="margin:0">Business · Annual</dd>
  <dt class="mock-label">Renewal</dt><dd style="margin:0">Jun 30, 2026</dd>
</dl>
```
