# Textarea

## When to use
- Multi-line free text: comments, descriptions, messages, bios
- Expected input ≥ 2 lines

## When NOT to use
- Single line → [text-input.md](text-input.md)
- Rich-text editing (formatting, links, images) → use a rich-text editor pattern (out of scope for wireframes; show as `<div class="placeholder">Rich-text editor</div>`)
- Code → use a code-editor pattern with monospace font

## Anatomy
1. Visible label above
2. Textarea field, rows attribute set to expected size (3–5 typical)
3. Optional: character counter (esp. for tweets, SMS, bios)
4. Optional: resize handle (browser default)
5. Helper text or error message slot

## Required states
- default (empty)
- focused
- filled
- disabled
- error (with message)
- near-limit (counter approaching max)
- over-limit (counter past max, error styling)

## Best practices
1. Set `rows` to a sensible default (3–5) (N7) — don't force users to resize before typing
2. Allow vertical resize, lock horizontal (browser default; preserve it)
3. Character counter: visible from the start if there's a limit; turns warning color at 90% (N1)
4. Don't enforce max-length silently — show counter so user can see they're being cut off (N9)
5. Show errors below the field, not as tooltips (A4)
6. Use `aria-describedby` to link counter and error to the field (A4)
7. For long-form content, save drafts on blur (N3)

## Common mistakes
- Single-row textarea (looks like a text input) → users confused about expected length (N2)
- No counter on length-limited input → user hits limit mid-sentence with no warning (N1)
- Disable Submit when over limit without telling user → user hunts for the cause (N9)
- Auto-grow that pushes UI down causing layout shift → jarring (N4)
- No way to expand → limits long content unnecessarily

## Device variants
- **mobile-web/native**: increase rows to 4–5; resize handle disabled (use auto-grow instead)
- **desktop**: 3–4 rows default with manual resize allowed

## Skeleton

```html
<div class="wf-stack" style="max-width:600px">
  <label for="msg" class="mock-label">Message</label>
  <textarea id="msg" name="message" rows="4" maxlength="500"
            class="mock-input" placeholder="What changed in this release?"></textarea>
  <div class="wf-row" style="justify-content:space-between">
    <span class="wf-muted" style="font-size:12px">Markdown supported</span>
    <span id="msg-count" class="wf-muted" style="font-size:12px">0 / 500</span>
  </div>
</div>
```
