# Toast (Snackbar)

## When to use
- Transient confirmation of an action: "Saved", "Copied", "Sent"
- Non-blocking feedback that doesn't require user response
- Brief notifications that auto-dismiss

## When NOT to use
- Errors that block progress → [inline-error.md](inline-error.md) or [modal.md](modal.md)
- Critical info user MUST see → [banner.md](banner.md)
- Confirming destructive actions BEFORE they happen → [confirmation-dialog.md](confirmation-dialog.md)

## Anatomy
1. Container (corner of viewport, typically bottom-right or top)
2. Icon (success / info / warning / error)
3. Message (concise, past-tense for confirmations)
4. Optional: action button ("Undo", "View")
5. Auto-dismiss timer (3–5 seconds typical)
6. Close affordance for screen reader / keyboard users

## Required states
- success
- info
- warning
- error
- with-action ("Undo")
- stacked (multiple toasts)
- pinned (action present, doesn't auto-dismiss)

## Best practices
1. Position consistently — pick top OR bottom and stick (N4)
2. Auto-dismiss in 4–6 seconds; pause on hover/focus (N1, A3)
3. If toast has an action ("Undo"), DON'T auto-dismiss until user dismisses or acts (N3)
4. Stack vertically with newest at edge (top of stack on bottom-positioned, etc.) (N4)
5. Keep message ≤ 1 line (≤ 60 chars) (G4)
6. Use `role="status"` for non-urgent and `role="alert"` for errors (A1)
7. Icon + color + text — never color alone (A2)
8. Close button for keyboard / screen-reader users (A3)
9. Don't use for important info — toasts disappear (N1, N9)

## Common mistakes
- Toasts for critical errors → user might miss them (N9)
- Auto-dismiss too fast (< 3s) → user can't read (N1)
- Auto-dismiss while pointing at "Undo" button → action lost (N3)
- 5+ toasts stacked → overload (F2)
- No close button → fails keyboard users (A3)
- Toasts that block content → defeats their purpose (N3)

## Device variants
- **desktop-web/-app**: bottom-right corner; offset from viewport edge
- **mobile-web**: bottom of viewport, full-width; respect safe-area
- **ios-app**: top, banner-style
- **android-app**: bottom snackbar (Material spec)

## Skeleton

```html
<!-- Container, fixed at bottom-right -->
<div role="region" aria-label="Notifications"
     style="position:fixed;bottom:1rem;right:1rem;display:flex;flex-direction:column;gap:.5rem;z-index:100">

  <div role="status" class="mock-card wf-row" style="background:var(--wf-text);color:var(--wf-surface);min-width:280px">
    <span aria-hidden="true">✓</span>
    <span class="wf-grow">Deal saved</span>
    <button class="mock-button" style="color:var(--wf-accent);background:transparent;border:0">Undo</button>
    <button class="mock-button" aria-label="Dismiss" style="color:inherit;background:transparent;border:0">×</button>
  </div>

  <div role="alert" class="mock-card wf-row" style="background:var(--wf-error);color:#fff;min-width:280px">
    <span aria-hidden="true">⚠</span>
    <span class="wf-grow">Couldn't connect to server</span>
    <button class="mock-button" style="color:#fff;background:transparent;border:0">Retry</button>
  </div>
</div>
```
