# Modal (Dialog)

## When to use
- Focused subtask requiring user attention
- Quick form entry that doesn't justify a full page
- Confirming destructive actions → [confirmation-dialog.md](confirmation-dialog.md) (specialized variant)
- Showing supplementary detail without losing context

## When NOT to use
- Long workflows → use a full page or [multi-step-form.md](../forms/multi-step-form.md)
- Information user needs alongside underlying content → side rail or popover
- Trivial info → [tooltip.md](../content/tooltip.md) or [toast.md](toast.md)
- Stacking multiple modals → redesign the flow

## Anatomy
1. Scrim/overlay behind modal (dims background)
2. Modal container (centered, max-width)
3. Header: title, optional close button (×)
4. Body: content/form
5. Footer: action buttons (Cancel left or right depending on convention, primary action)

## Required states
- default (open)
- with-form-content
- form-with-pending-changes
- submitting
- submission-error
- mobile-fullscreen (sheet variant)

## Best practices
1. Trap focus inside modal when open (A1, A3)
2. First focusable element receives focus on open; restore focus on close (A3)
3. Close on: Esc key, click outside (scrim), explicit X button — provide all three (N3)
4. EXCEPT confirmation dialogs for destructive actions: don't close on outside click (N5)
5. Title clearly states what the modal is for (N2) — verb noun: "Add team member"
6. Primary action right-aligned in footer (N4) — Cancel left of primary
7. Max width ~480 px for short content, ~640 px for forms; never full-viewport on desktop (G4)
8. Mobile: use full-screen sheet, not centered modal (D1)
9. ARIA: `role="dialog"`, `aria-modal="true"`, `aria-labelledby` pointing to title (A1)
10. Don't open modals from modals — redesign

## Common mistakes
- No focus trap → keyboard users tab into background (A3)
- Modal opens with no clear close affordance (no X, can't click outside) → user stuck (N3)
- Closes on outside click during destructive confirmation → accidental dismissal (N5)
- Modal too large → no longer focused, just a popup window (G4)
- Stacked modals → users lose context (N6)
- Long forms in modals → bad UX; use a full page (G4)

## Device variants
- **desktop-web/-app**: centered modal with scrim
- **mobile-web/native**: full-screen sheet; respects safe-area
- **ios-app**: sheet (slides from bottom); large title; system close button
- **android-app**: dialog (Material) or full-screen sheet

## Skeleton

```html
<!-- Scrim -->
<div style="position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:50"></div>

<!-- Modal -->
<div role="dialog" aria-modal="true" aria-labelledby="modal-title"
     style="position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);width:90%;max-width:480px;z-index:51"
     class="mock-card">

  <header class="wf-row" style="justify-content:space-between;align-items:flex-start">
    <h2 id="modal-title" style="font-size:18px;margin:0">Add team member</h2>
    <button class="mock-button" aria-label="Close">×</button>
  </header>

  <div class="wf-stack" style="margin:1rem 0">
    <div class="wf-stack">
      <label class="mock-label" for="invite-email">Email</label>
      <input id="invite-email" class="mock-input" type="email" placeholder="teammate@acme.com">
    </div>
    <div class="wf-stack">
      <label class="mock-label" for="invite-role">Role</label>
      <select id="invite-role" class="mock-input">
        <option>Member</option>
        <option>Admin</option>
      </select>
    </div>
  </div>

  <footer class="wf-row" style="justify-content:flex-end">
    <button class="mock-button">Cancel</button>
    <button class="mock-button mock-button--primary">Send invite</button>
  </footer>
</div>
```
