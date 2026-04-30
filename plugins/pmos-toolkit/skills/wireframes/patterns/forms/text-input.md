# Text Input

## When to use
- Single-line free-text entry: name, email, search query, URL, short codes

## When NOT to use
- ≥ 2 lines expected → [textarea.md](textarea.md)
- Choosing from known options → [select-dropdown.md](select-dropdown.md)
- Dates → [date-picker.md](date-picker.md)
- Search with results → [search.md](search.md)

## Anatomy
1. Visible label above the input
2. Input field
3. Optional: helper text below the input
4. Optional: prefix/suffix icon (e.g., `$` for currency, magnifier for search)
5. Optional: character counter for length-limited fields
6. Error message slot (replaces helper text on error)

## Required states
- default (empty)
- focused
- filled (with content)
- disabled
- read-only
- error (with message)
- success (rare; only when explicit confirmation matters)

## Best practices
1. **Always use a visible label above the field** (A4, N6) — placeholder-as-label fails screen readers and disappears on input
2. Use `type="email"`, `type="tel"`, `type="url"` — triggers correct mobile keyboard (D1, N7)
3. Use `autocomplete` attributes (`name`, `email`, `tel`) — saves user effort (N7)
4. Field width should hint at expected length: zip = narrow, email = wide (N2)
5. Error messages: specific + actionable ("Email must include @" not "Invalid input") (N9)
6. Required fields marked with `*` AND `aria-required="true"` (A4) — never rely on color alone
7. Don't disable Submit until valid; let user submit and show errors → faster correction loop
8. Touch targets ≥ 44 px tall on mobile (F1, A5)
9. Error state shown with icon + color + text, not color alone (A2, N9)

## Common mistakes
- Placeholder used as the only label → fails A4, recall over recognition (N6)
- Generic error "Invalid input" → user has no idea what to fix (N9)
- Centered placeholder text → makes empty fields look filled
- Required marked only by color → colorblind users miss it (A2)
- All caps labels → harder to read, not impressive (G3)
- Inputs that auto-format aggressively (e.g., trimming hyphens user typed) without showing what happened → confusing

## Device variants
- **mobile-web/native**: ≥ 44 px height, large tap area; correct keyboard via type/inputmode
- **desktop**: 36–40 px height typical
- **ios-app**: native input picks up system styling; respect Dynamic Type
- **android-app**: Material outlined or filled style

## Skeleton

```html
<div class="wf-stack" style="max-width:360px">
  <label for="email" class="mock-label">Email <span aria-hidden="true">*</span></label>
  <input id="email" name="email" type="email" autocomplete="email" required
         class="mock-input" placeholder="you@company.com">
  <span class="wf-muted" style="font-size:12px">We'll send confirmation here.</span>
</div>

<!-- Error state -->
<div class="wf-stack" style="max-width:360px">
  <label for="email-2" class="mock-label">Email <span aria-hidden="true">*</span></label>
  <input id="email-2" type="email" aria-invalid="true" aria-describedby="email-2-err"
         class="mock-input" style="border-color:var(--wf-error)" value="maneesh@">
  <span id="email-2-err" style="color:var(--wf-error);font-size:12px">⚠ Email must include a domain (e.g. acme.com)</span>
</div>
```
