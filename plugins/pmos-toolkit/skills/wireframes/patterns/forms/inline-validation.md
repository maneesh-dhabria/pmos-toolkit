# Inline Validation

## When to use
- Field-level feedback DURING form entry (not only on submit)
- Fields with strict format requirements (email, password, username availability)
- Forms where errors are common and correctable

## When NOT to use
- Trivial fields ("First name") → submit-time validation is fine
- Single-input forms → submit-time is enough
- Real-time validation that fires on every keystroke for fields without strict format → noisy

## Anatomy
1. Field with input
2. Validation trigger: typically on blur, sometimes on input for special cases (password strength)
3. Error message below the field
4. Error icon inline with the field
5. Optional: success indicator for validated fields (✓)
6. Optional: live requirements list (password strength)

## Required states
- pristine (untouched, no validation yet)
- focused (typing, no errors shown yet)
- valid (passed validation; success affordance)
- invalid (failed validation; error shown)
- pending (async check in flight, e.g., username availability)

## Best practices
1. Validate on blur, not on every keystroke (N1) — keystroke validation is noisy and premature
2. EXCEPT password strength meters and async checks (username availability) — those benefit from live feedback (N1)
3. Clear errors as soon as input becomes valid (N1) — don't make user click out and back
4. Error messages: specific + actionable ("Must be at least 8 characters" not "Invalid") (N9)
5. Use icon + color + text for error (A2) — color alone fails colorblind users
6. Mark invalid fields with `aria-invalid="true"` and link error via `aria-describedby` (A4)
7. Success indicators (✓) should be optional and subtle — not on every field (N8)
8. On submit, focus the FIRST invalid field and announce errors (A3, N9)

## Common mistakes
- Validating on every keystroke from the first character → "Invalid email" while user types "m" (N1)
- Generic error messages → user can't fix the problem (N9)
- Errors disappear only on submit, not on correction → user can't tell they fixed it (N1)
- Color-only error indication → fails colorblind / low-vision (A2)
- Submit button disabled with no explanation → user can't proceed and doesn't know why (N9)
- Errors appear far from the field → user has to hunt for the cause (N9)

## Device variants
- **mobile-web/native**: errors below field; ensure error doesn't push Submit off screen
- **desktop**: errors below or to the right; keep within viewport

## Skeleton

```html
<!-- Pristine -->
<div class="wf-stack" style="max-width:360px">
  <label for="pw" class="mock-label">Password</label>
  <input id="pw" type="password" class="mock-input">
  <ul class="wf-stack" style="list-style:none;padding:0;font-size:12px">
    <li class="wf-muted">○ At least 8 characters</li>
    <li class="wf-muted">○ One number</li>
    <li class="wf-muted">○ One symbol</li>
  </ul>
</div>

<!-- Live feedback as user types -->
<div class="wf-stack" style="max-width:360px">
  <label for="pw2" class="mock-label">Password</label>
  <input id="pw2" type="password" class="mock-input" value="hunter2!" aria-describedby="pw2-rules">
  <ul id="pw2-rules" class="wf-stack" style="list-style:none;padding:0;font-size:12px">
    <li style="color:var(--wf-success)">✓ At least 8 characters</li>
    <li style="color:var(--wf-success)">✓ One number</li>
    <li style="color:var(--wf-success)">✓ One symbol</li>
  </ul>
</div>

<!-- Error state -->
<div class="wf-stack" style="max-width:360px">
  <label for="email" class="mock-label">Email</label>
  <input id="email" type="email" value="maneesh@" aria-invalid="true" aria-describedby="email-err"
         class="mock-input" style="border-color:var(--wf-error)">
  <span id="email-err" style="color:var(--wf-error);font-size:12px">⚠ Email needs a domain (e.g. acme.com)</span>
</div>
```
