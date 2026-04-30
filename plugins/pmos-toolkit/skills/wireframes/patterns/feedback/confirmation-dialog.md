# Confirmation Dialog

## When to use
- Destructive actions: delete, remove, archive, cancel-subscription
- Irreversible actions: send, publish, charge
- Anything where Undo is impossible or expensive

## When NOT to use
- Reversible actions with Undo support → use [toast.md](toast.md) with Undo instead (better flow)
- Routine confirmations the user does 50× a day → fatigue makes confirmations ignored (N5)
- Non-destructive form submission → just submit; don't double-confirm

## Anatomy
1. Scrim
2. Dialog container (smaller than a typical modal)
3. Title clearly stating the action
4. Body explaining consequences ("This will delete 12 records and cannot be undone.")
5. For high-stakes: type-to-confirm input ("Type DELETE to confirm")
6. Footer: Cancel (default focus) + destructive primary button

## Required states
- default
- with-type-to-confirm-empty (primary disabled)
- with-type-to-confirm-typed (primary enabled)
- submitting
- submission-error

## Best practices
1. Title is the action: "Delete project?" (N2) — not "Are you sure?"
2. Body explains scope and irreversibility (N5, N9)
3. Cancel button gets default focus (N5) — protects against accidental Enter
4. Destructive button uses `mock-button--danger` color + clear label ("Delete") (A2, N4)
5. NO close-on-outside-click for destructive (N5) — too easy to dismiss accidentally
6. For very high stakes: require typing the entity name to enable Delete (N5) — friction is the point
7. After action: toast confirmation with Undo if possible (N3)
8. Show what will be deleted (entity count, name) in body (N1)
9. ARIA `role="alertdialog"` for destructive vs `role="dialog"` (A1)

## Common mistakes
- "Are you sure?" → unhelpful (N9). Say what action and what consequence.
- Destructive button gets default focus → accidental Enter destroys data (N5)
- Same color for Cancel and Delete → user picks the wrong one (A2, N4)
- Closes on outside click → too easy to dismiss without thinking (N5)
- Confirmation for trivial reversible action → fatigue
- No mention of what gets deleted → user can't tell scope

## Device variants
- **desktop**: centered, max-width ~420 px
- **mobile-web/native**: full-screen sheet OR Material/iOS native action sheet style

## Skeleton

```html
<!-- Scrim -->
<div style="position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:50"></div>

<div role="alertdialog" aria-modal="true" aria-labelledby="confirm-title" aria-describedby="confirm-body"
     style="position:fixed;top:40%;left:50%;transform:translate(-50%,-50%);width:90%;max-width:420px;z-index:51"
     class="mock-card">

  <h2 id="confirm-title" style="font-size:18px;margin:0">Delete "Acme Pilot Q3"?</h2>

  <p id="confirm-body" style="margin:.75rem 0">
    This will permanently delete the deal and all 14 associated activities.
    <strong>This cannot be undone.</strong>
  </p>

  <div class="wf-stack" style="margin:.75rem 0">
    <label class="mock-label" for="confirm-input">Type <code>Acme Pilot Q3</code> to confirm</label>
    <input id="confirm-input" class="mock-input" placeholder="Acme Pilot Q3">
  </div>

  <footer class="wf-row" style="justify-content:flex-end">
    <button class="mock-button" autofocus>Cancel</button>
    <button class="mock-button mock-button--danger" disabled>Delete</button>
  </footer>
</div>
```
