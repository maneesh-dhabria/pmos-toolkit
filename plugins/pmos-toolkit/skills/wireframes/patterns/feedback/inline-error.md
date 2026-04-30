# Inline Error

## When to use
- Field-scoped error feedback (form validation)
- Errors localized to a specific element / control

## When NOT to use
- Page-level errors → [banner.md](banner.md)
- Whole-screen failures → [error-state.md](error-state.md)
- Transient action errors → [toast.md](toast.md)

## Anatomy
1. Field with error styling (red border)
2. Error icon
3. Error message DIRECTLY below the field
4. ARIA association via `aria-describedby` and `aria-invalid="true"`

## Required states
- field-with-single-error
- field-with-multiple-errors (rare; usually pick the most actionable one)
- error-cleared (success or back to default)

## Best practices
1. Place error directly below the field, not at the top of the form (N9) — connect cause to effect
2. Specific + actionable: "Email must include @" not "Invalid" (N9)
3. Don't repeat the field name — user already knows ("Email is required" → "Required")
4. Icon + color + text (A2)
5. `aria-invalid="true"` on field; `aria-describedby` linking to error message id (A4)
6. Clear the error as soon as input becomes valid (N1) — don't wait for blur
7. On submit failure, focus the FIRST invalid field and announce summary at top (A3)
8. Don't shake/animate aggressively — distracting (N8)

## Common mistakes
- "Invalid email" → user already knew; what's invalid? (N9)
- Errors only at top of page → user has to find which field (N9)
- Color-only indication → fails colorblind (A2)
- Error persists after correction → user thinks it's still broken (N1)
- Showing all 5 errors at once on a single field → overwhelming. Pick most actionable.

## Device variants
- **desktop / mobile**: error directly below field
- **mobile**: ensure error doesn't push the next field below the keyboard fold

## Skeleton

```html
<div class="wf-stack" style="max-width:360px">
  <label for="email" class="mock-label">Email</label>
  <input id="email" type="email" value="maneesh@" aria-invalid="true" aria-describedby="email-error"
         class="mock-input" style="border-color:var(--wf-error)">
  <span id="email-error" class="wf-row" style="color:var(--wf-error);font-size:12px;gap:.25rem">
    <span aria-hidden="true">⚠</span>
    <span>Email needs a domain (e.g. acme.com)</span>
  </span>
</div>
```
