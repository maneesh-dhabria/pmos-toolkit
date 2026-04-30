# Tooltip

## When to use
- Brief supplementary info on hover or focus (≤ 1 sentence)
- Explaining icon-only buttons
- Showing full text of truncated content
- Keyboard shortcut hints

## When NOT to use
- Critical info user MUST see → use [banner.md](../feedback/banner.md) or visible helper text
- Form-field help → use inline helper text below the field
- Long explanations → use a popover or "Learn more" link
- On touch-only surfaces (no hover) → tooltips don't trigger; use a `?` button + popover instead

## Anatomy
1. Small floating panel near the trigger
2. Short text (≤ 80 chars / one sentence)
3. Pointer/arrow indicating the trigger
4. Trigger: an element with `aria-describedby` or a `?` icon

## Required states
- closed
- open (hover / focus)
- pressed (touch — usually doesn't show; consider popover instead)

## Best practices
1. Show on hover AND on keyboard focus (A3)
2. Delay opening by ~300–500 ms — prevents tooltip storm on fast mouse movement (N8)
3. Hide on Esc, on blur, on mouseout (N3)
4. Position adaptively — flip if no room (N4)
5. ARIA: tooltip content has `role="tooltip"`, trigger uses `aria-describedby` pointing to it (A1, A4)
6. Don't put interactive elements in tooltips — they disappear on hover-out (N3)
7. Touch fallback: tooltip turns into a popover on tap, with explicit close (D1)
8. Never use tooltip for the ONLY explanation of an icon-only button — also use a visible label or screen-reader text (A4)

## Common mistakes
- Tooltip is the only explanation of an icon → fails touch users and screen readers (D1, A4)
- Long paragraphs in tooltip → use a popover (N8)
- Interactive content (buttons, links) inside → unreachable (N3)
- Tooltip covers the trigger → user can't see what they're hovering
- Instant open with no delay → flickers as user crosses hover targets

## Device variants
- **desktop**: hover/focus tooltips
- **mobile/native**: tooltips don't work (no hover); use "?" icon → popover or [banner.md](../feedback/banner.md)

## Skeleton

```html
<!-- Trigger with tooltip -->
<span style="position:relative;display:inline-block">
  <button class="mock-button" aria-label="Help" aria-describedby="tip-pw">?</button>

  <!-- Tooltip (open state) -->
  <div role="tooltip" id="tip-pw"
       style="position:absolute;bottom:calc(100% + 8px);left:50%;transform:translateX(-50%);
              background:var(--wf-text);color:var(--wf-surface);padding:.4rem .6rem;
              border-radius:var(--wf-radius);font-size:12px;white-space:nowrap;z-index:10">
    Min 8 chars, one number, one symbol
    <span aria-hidden="true"
          style="position:absolute;top:100%;left:50%;transform:translateX(-50%);
                 border:5px solid transparent;border-top-color:var(--wf-text)"></span>
  </div>
</span>

<!-- Icon button with both visible label and tooltip on hover -->
<button class="mock-button" aria-describedby="tip-export" aria-label="Export to CSV">
  ⬇ Export
</button>
<div role="tooltip" id="tip-export" style="display:none">Download all rows as CSV (⌘E)</div>
```
