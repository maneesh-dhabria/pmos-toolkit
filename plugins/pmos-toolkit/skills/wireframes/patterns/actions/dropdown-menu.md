# Dropdown Menu

## When to use
- 3+ secondary actions on an entity (table row, card)
- Overflow when too many actions to fit inline
- Account / profile menus

## When NOT to use
- Single primary action → just a button
- Choosing one of N options to commit (form value) → [select-dropdown.md](../forms/select-dropdown.md)
- Toggling a binary state → switch / checkbox

## Anatomy
1. Trigger button (often a `⋯` icon, sometimes labeled "Actions ▾")
2. Menu panel (popover)
3. Menu items: icon (optional) + label + shortcut hint (optional)
4. Optional: separators between groups
5. Optional: destructive item separated and styled with red

## Required states
- closed
- open
- with-disabled-item
- with-destructive-item-styled
- item-hovered
- item-focused (keyboard)

## Best practices
1. Trigger is `⋯` (three dots) for "more actions" or "Action ▾" for explicit menus (N2, N4)
2. Open on click, NOT hover (hover menus are flaky on touch + accidental opens) (D1)
3. Keyboard support: Enter/Space opens; arrow keys move; Esc closes; Tab moves focus out (A3)
4. ARIA: `role="menu"`, items `role="menuitem"`, trigger has `aria-haspopup="menu"` and `aria-expanded` (A1)
5. Destructive actions at the bottom, separated, styled red (G1, N5)
6. Show keyboard shortcuts inline if applicable (N7)
7. Close on selection unless menu is intentionally multi-step
8. Position menu so it stays in viewport (flip up if no room below)
9. Touch target ≥ 44 px tall (F1, A5)

## Common mistakes
- Hover-only triggers → broken on touch (D1)
- No keyboard navigation → fails accessibility (A3)
- Destructive in the middle of the list → easy mis-click (N5, G1)
- Too many items (10+) → use a search-enabled menu or rethink IA (F2)
- Menu opens off-screen with no flip → users can't see items
- `⋯` with no `aria-label` → screen readers say "more horizontal" or nothing (A4)

## Device variants
- **desktop**: popover anchored to trigger
- **mobile-web**: bottom sheet replaces popover (more thumb-reachable, F1)
- **ios-app**: Action Sheet or context menu
- **android-app**: Material menu or bottom sheet

## Skeleton

```html
<button class="mock-button" aria-haspopup="menu" aria-expanded="true" aria-label="More actions">⋯</button>

<div role="menu" class="mock-card" style="position:absolute;min-width:200px;padding:.25rem">
  <button role="menuitem" class="wf-row" style="width:100%;padding:.5rem;background:transparent;border:0;text-align:left;cursor:pointer">
    <span aria-hidden="true">✏️</span><span class="wf-grow">Edit</span><span class="wf-muted" style="font-size:12px">⌘E</span>
  </button>
  <button role="menuitem" class="wf-row" style="width:100%;padding:.5rem;background:transparent;border:0;text-align:left;cursor:pointer">
    <span aria-hidden="true">📋</span><span class="wf-grow">Duplicate</span>
  </button>
  <button role="menuitem" class="wf-row" style="width:100%;padding:.5rem;background:transparent;border:0;text-align:left;cursor:pointer">
    <span aria-hidden="true">📤</span><span class="wf-grow">Share…</span>
  </button>
  <hr class="mock-divider">
  <button role="menuitem" class="wf-row" style="width:100%;padding:.5rem;background:transparent;border:0;text-align:left;cursor:pointer;color:var(--wf-error)">
    <span aria-hidden="true">🗑️</span><span class="wf-grow">Delete</span>
  </button>
</div>
```
