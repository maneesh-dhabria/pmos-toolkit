# Banner (Inline Alert)

## When to use
- Persistent, page-level information user should see while working
- System status: maintenance windows, plan limits, billing issues
- Account-level warnings: trial expiring, feature deprecation

## When NOT to use
- Transient confirmation → [toast.md](toast.md)
- Field-level error → [inline-error.md](inline-error.md)
- Blocking action confirmation → [confirmation-dialog.md](confirmation-dialog.md)
- Marketing announcements → users learn to ignore "promotional" banners

## Anatomy
1. Container with semantic color (info / warning / error / success)
2. Icon
3. Message text (concise but complete)
4. Optional: primary action button
5. Optional: dismiss (×) for dismissible banners
6. Position: top of page (most prominent) or section-scoped

## Required states
- info
- warning
- error
- success
- with-action
- dismissible vs persistent

## Best practices
1. Page-top banner for account-level info; section-scoped for content-specific (N4)
2. Color coding + icon + text (A2) — never color alone
3. Concise but complete — explain WHAT and what to DO (N9)
4. Dismiss only if reappearing on next page-load makes sense; persist critical issues (N5)
5. Primary action inline ("Renew now", "Update card") (F1)
6. ARIA `role="status"` for info/success, `role="alert"` for warning/error (A1)
7. Keep ≤ 2 lines in normal viewport (G4)
8. Don't stack multiple banners — pick the most important (F2)

## Common mistakes
- Stacking 3 banners → user blindness (F2)
- Critical billing banner that's dismissible and gone forever → user misses it (N5)
- Color-only severity → fails colorblind (A2)
- Banner buried in a sidebar → low visibility (N1)
- Banner that looks too much like an ad → ignored

## Device variants
- **desktop-web/-app**: full-width across content area
- **mobile-web/native**: full-width edge-to-edge; respect safe-area

## Skeleton

```html
<!-- Warning banner with action -->
<div role="alert" class="wf-row" style="background:#fef3c7;border:1px solid #f59e0b;border-radius:var(--wf-radius);padding:.75rem 1rem;gap:.75rem">
  <span aria-hidden="true" style="color:#92400e">⚠</span>
  <div class="wf-grow">
    <strong>Trial ends in 3 days.</strong>
    Add a payment method to keep access to all features.
  </div>
  <button class="mock-button mock-button--primary">Add card</button>
  <button class="mock-button" aria-label="Dismiss">×</button>
</div>

<!-- Info banner -->
<div role="status" class="wf-row" style="background:#dbeafe;border:1px solid #3b82f6;border-radius:var(--wf-radius);padding:.75rem 1rem;gap:.75rem">
  <span aria-hidden="true" style="color:#1e40af">ℹ</span>
  <div class="wf-grow">Scheduled maintenance: Saturday April 25, 02:00–04:00 UTC.</div>
</div>

<!-- Error banner -->
<div role="alert" class="wf-row" style="background:#fee2e2;border:1px solid var(--wf-error);border-radius:var(--wf-radius);padding:.75rem 1rem;gap:.75rem">
  <span aria-hidden="true" style="color:var(--wf-error)">⚠</span>
  <div class="wf-grow">
    <strong>Payment failed.</strong>
    Update your card to avoid service interruption.
  </div>
  <button class="mock-button mock-button--primary">Update card</button>
</div>
```
