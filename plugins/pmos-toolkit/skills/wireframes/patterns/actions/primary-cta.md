# Primary CTA

## When to use
- The single most important action on a screen
- "Save", "Submit", "Buy now", "Send", "Continue"

## When NOT to use
- Equal-weight peer actions → [button-group.md](button-group.md)
- Many secondary actions → [dropdown-menu.md](dropdown-menu.md)
- Floating creation action on mobile → [fab.md](fab.md)

## Anatomy
1. Single visually dominant button
2. Action verb as label
3. Optional: leading icon
4. Optional: shortcut hint (`⌘ + Enter`)

## Required states
- default
- hover
- focus (keyboard)
- pressed
- loading (spinner inside button, label changes to "Saving…")
- disabled (with reason if not obvious)
- success (brief; reverts after a moment)

## Best practices
1. ONE primary per logical section (G3) — multiple primaries dilute meaning
2. Label is a verb-noun: "Save changes", "Send invite" (N2) — not "OK"
3. Position: footer-right in dialogs, top-right or bottom-right in pages (N4) — depends on platform convention
4. Accent color fill, white text (G3, A2)
5. Disabled state explains why ("Required fields missing") via tooltip or helper text (N9)
6. Loading: change label to gerund ("Saving…") and show spinner; don't disable text completely (N1)
7. Touch target ≥ 44 px tall on mobile (F1, A5)
8. Keyboard activation via Enter/Space; don't use only mouse handlers (A3)

## Common mistakes
- 3 "primary" buttons on one screen → none feels primary (G3)
- "OK" / "Submit" → vague (N2)
- Disabled with no explanation → user confused (N9)
- Loading state vanishes the label → user can't tell what's happening (N1)
- Tiny CTA on a marketing page → conversion killer (F1)

## Device variants
- **desktop**: typical 36–40 px height
- **mobile/native**: ≥ 44 px height; consider full-width sticky CTA at bottom for primary actions
- **ios-app**: rounded rect, system tint
- **android-app**: Material elevated or filled button

## Skeleton

```html
<!-- Default -->
<button class="mock-button mock-button--primary">Save changes</button>

<!-- Loading -->
<button class="mock-button mock-button--primary" disabled aria-busy="true">
  <span class="skeleton" style="width:14px;height:14px;border-radius:50%"></span>
  Saving…
</button>

<!-- With shortcut hint -->
<button class="mock-button mock-button--primary">
  Send <span class="mock-pill" style="background:rgba(255,255,255,.2);color:inherit">⌘↵</span>
</button>

<!-- Disabled with helper -->
<div class="wf-stack">
  <button class="mock-button mock-button--primary" disabled aria-describedby="cta-hint">Save changes</button>
  <span id="cta-hint" class="wf-muted" style="font-size:12px">Add a project name to enable saving.</span>
</div>
```
